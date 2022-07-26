class Transaction {
  final String id;
  final String description;
  final DateTime date;
  final double amount;
  final TransactionType type;

  Transaction(this.id, this.description, this.date, this.amount, this.type);
}

enum TransactionType { expense, income }