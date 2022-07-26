import 'package:ewallet/features/modfiy_transaction/screens/modify_transaction_screen.dart';
import 'package:ewallet/state/state_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key}) : super(key: key);

  void deleteTransaction(BuildContext context, String transactionId) {
    StateContainer.of(context).deleteTransaction(transactionId);
  }

  void navigateToModifyTransactionScreen(
      BuildContext context, String transactionId) {
    Navigator.of(context)
        .pushNamed(ModifyTranactionScreen.routeName, arguments: transactionId);
  }

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          onDismissed: (_) {
            deleteTransaction(context, state.transactions[index].id);
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(10),
            child: const Icon(Icons.delete, color: Colors.white, size: 40),
          ),
          key: ValueKey(state.transactions[index].id),
          child: Card(
              child: ListTile(
            leading: IconButton(
              onPressed: () {
                navigateToModifyTransactionScreen(
                    context, state.transactions[index].id);
              },
              icon: const Icon(Icons.edit),
              color: Colors.black,
              iconSize: 40,
            ),
            title: Text(
              state.transactions[index].description,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              DateFormat.yMMMMd('hu').format(state.transactions[index].date),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            trailing: Text(
              NumberFormat.currency(
                      locale: 'hu', decimalDigits: 2, symbol: 'Ft')
                  .format(state.transactions[index].amount),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Color(0xFF0E0E0D)),
            ),
          )),
        );
      },
      itemCount: state.transactions.length,
    );
  }
}
