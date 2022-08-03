import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Transaction {
  @HiveField(0)
  final int id;
  final String description;
  final DateTime date;
  final double amount;
  final TransactionType type;

  Transaction(this.id, this.description, this.date, this.amount, this.type);
}

enum TransactionType { expense, income }