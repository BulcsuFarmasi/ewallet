import 'package:ewallet/database/total_amount_handler.dart';
import 'package:ewallet/database/transactions_handler.dart';
import 'package:ewallet/models/transaction.dart';
import 'package:ewallet/state/state_container.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StateProvider extends StatefulWidget {
  const StateProvider({required this.child, super.key});

  final Widget child;

  @override
  State<StateProvider> createState() => StateProviderState();
}

class StateProviderState extends State<StateProvider> {
  double? totalAmount;
  List<Transaction> transactions = [];

  final _transactionsHandler = TransactionsHandler();
  final _totalAmountHandler = TotalAmountHandler();

  @override
  void initState() {
    super.initState();
    Future.wait([_totalAmountHandler.open(), _transactionsHandler.open()])
        .then((_) {
      setState(() {
        totalAmount = _totalAmountHandler.getTotalAmount();
        transactions = _transactionsHandler.getTransactions();
        sortTransactions();
      });
    });
  }

  void modifyTotalAmount(double newTotalAmount) {
    setState(() {
      totalAmount = newTotalAmount;
    });
    _totalAmountHandler.modifyTotalAmount(newTotalAmount);
  }

  void addTransaction(
      {required String description,
      required double amount,
      required TransactionType type,
      required DateTime date}) {
    final uuid = Uuid();
    final id = uuid.v1();
    if (type == TransactionType.expense) {
      amount *= -1;
    }
    final transaction = Transaction(id, description, date, amount, type);
    setState(() {
      transactions = [...transactions, transaction];
      sortTransactions();
    });
    modifyTotalAmount(totalAmount! + amount);
    _transactionsHandler.addTransaction(transaction);
  }

  void editTransaction(
      {required String id,
      required String description,
      required double amount,
      required TransactionType type,
      required DateTime date}) {
    if (type == TransactionType.expense) {
      amount *= -1;
    }

    final editedTransaction = Transaction(id, description, date, amount, type);
    final transactionIndex = transactions
        .indexWhere((Transaction transaction) => transaction.id == id);

    final difference =
        editedTransaction.amount - transactions[transactionIndex].amount;

    setState(() {
      transactions = [
        ...transactions.sublist(0, transactionIndex),
        editedTransaction,
        ...transactions.sublist(transactionIndex + 1)
      ];
      sortTransactions();
    });

    modifyTotalAmount(totalAmount! + difference);
    _transactionsHandler.modifyTransaction(editedTransaction);
  }

  Transaction findTransactionById(String transactionId) {
    return transactions.firstWhere(
        (Transaction transaction) => transaction.id == transactionId);
  }

  void deleteTransaction(String transactionId) {
    final transaction = findTransactionById(transactionId);
    modifyTotalAmount(totalAmount! - transaction.amount);
    setState(() {
      transactions = transactions
          .where((Transaction transaction) => transaction.id != transactionId)
          .toList();
    });
    _transactionsHandler.deleteTransaction(transactionId);
  }

  void sortTransactions() {
    transactions.sort((Transaction aTransaction, Transaction bTransaction) {
      return bTransaction.date.compareTo(aTransaction.date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StateContainer(
      totalAmount: totalAmount,
      transactions: transactions,
      stateProviderState: this,
      child: widget.child,
    );
  }
}
