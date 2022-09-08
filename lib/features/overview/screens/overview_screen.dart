import 'package:ewallet/features/modfiy_transaction/screens/modify_transaction_screen.dart';
import 'package:ewallet/features/overview/widgets/transaction_list.dart';
import 'package:ewallet/state/state_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  static const routeName = '/overview';

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Áttekintés'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'PÉNZTÁRCÁM',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                'Jelenlegi összeg',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                NumberFormat.currency(locale: 'hu', decimalDigits: 2, symbol: 'Ft').format(state.totalAmount),
                style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              )
            ]),
            const SizedBox(
              height: 35,
            ),
            const Text(
              'Pénzmozgások',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(child: TransactionList()),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ModifyTranactionScreen.routeName);
                  },
                  child: const Text('Új pénzmozgás hozzáadása')),
            )
          ]),
        ));
  }
}
