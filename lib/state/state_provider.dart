import 'package:ewallet/models/transaction.dart';
import 'package:ewallet/state/state_container.dart';
import 'package:flutter/material.dart';

class StateProvider extends StatefulWidget {
  const StateProvider({required this.child, super.key});

  final Widget child;

  @override
  State<StateProvider> createState() => StateProviderState();
}

class StateProviderState extends State<StateProvider> {
  double totalAmount = 0;
  List<Transaction> transactions = [];

  void modifyTotalAmount(double newTotalAmount) {
    setState(() {
      totalAmount = newTotalAmount;
    });
  }

  void addTransaction(
      {required String description,
      required double amount,
      required TransactionType type,
      required DateTime date}) {
    final id = DateTime.now().microsecondsSinceEpoch;
    if (type == TransactionType.expense) {
      amount *= -1;
    }
    final transaction = Transaction(id, description, date, amount, type);
    setState(() {
      transactions = [...transactions, transaction];
    });
    modifyTotalAmount(totalAmount + amount);
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
