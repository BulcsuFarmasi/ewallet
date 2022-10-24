import 'package:ewallet/models/transaction.dart';
import 'package:hive/hive.dart';

class TransactionsHandler {

  Future<void> open() async {
    await Hive.openBox(boxName);
  }

  void addTransaction(Transaction transaction) {
    _editTransaction(transaction);
  }

  void modifyTransaction(Transaction transaction) {
    _editTransaction(transaction);
  }

  void _editTransaction(Transaction transaction) {
    Hive.box(boxName).put(transaction.id, transaction);
  }

  void deleteTransaction(String transactionId) {
    Hive.box(boxName).delete(transactionId);
  }

  List<Transaction> getTransactions() {
    return Hive.box(boxName).values.toList().cast<Transaction>();
  }



  static const boxName = 'transactions';
}