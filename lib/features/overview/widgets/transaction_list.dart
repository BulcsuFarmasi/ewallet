import 'package:ewallet/features/modfiy_transaction/screens/modify_transaction_screen.dart';
import 'package:ewallet/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  TransactionList({Key? key}) : super(key: key);

  final transactions = [
    Transaction(
      'aaa',
      'Dunaparty',
      DateTime(2022, 7, 25),
      -1220,
      TransactionType.expense,
    ),
    Transaction(
      'aaab',
      'Kivétel',
      DateTime(2022, 7, 21),
      19000,
      TransactionType.income,
    )
  ];

  void deleteTransaction(BuildContext context, String transactionId) {}

  void navigateToModifyTransactionScreen(
      BuildContext context, String transactionId) {
    Navigator.of(context)
        .pushNamed(ModifyTranactionScreen.routeName, arguments: transactionId);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          onDismissed: (_) {
            deleteTransaction(context, transactions[index].id);
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(10),
            child: const Icon(Icons.delete, color: Colors.white, size: 40),
          ),
          key: ValueKey(transactions[index].id),
          child: Card(
              child: ListTile(
            leading: IconButton(
              onPressed: () {
                navigateToModifyTransactionScreen(
                    context, transactions[index].id);
              },
              icon: const Icon(Icons.edit),
              color: Colors.black,
              iconSize: 40,
            ),
            title: Text(
              transactions[index].description,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              transactions[index].date.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            trailing: Text(
              '${transactions[index].amount.toStringAsFixed(0)}Ft',
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Color(0xFF0E0E0D)),
            ),
          )),
        );
      },
      itemCount: transactions.length,
    );
  }
}
