import 'package:ewallet/models/transaction.dart';
import 'package:ewallet/state/state_container.dart';
import 'package:flutter/material.dart';

class StateProvider extends StatefulWidget {
  const StateProvider({required this.child, super.key});

  final Widget child;

  @override
  State<StateProvider> createState() => _StateProviderState();
}

class _StateProviderState extends State<StateProvider> {

  double totalAmount = 0;
  List<Transaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    return StateContainer(child: widget.child, );
  }
}
