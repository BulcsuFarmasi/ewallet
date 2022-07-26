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

  void modifyTotalAmount (double newTotalAmount) {
    setState(() {
      totalAmount = newTotalAmount;
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
