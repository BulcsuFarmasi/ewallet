import 'package:ewallet/models/transaction.dart';
import 'package:ewallet/state/state_provider.dart';
import 'package:flutter/material.dart';

class StateContainer extends InheritedWidget {
  final double totalAmount;
  final List<Transaction> transactions;
  final StateProvider stateProvider;

  const StateContainer({required this.totalAmount, required this.transactions, required this.stateProvider, required super.child, super.key, });

  static StateProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<StateContainer>()!.stateProvider;

  @override
  bool updateShouldNotify(StateContainer oldWidget) {
    return totalAmount != oldWidget.totalAmount &&
        transactions != oldWidget.transactions;
  }
}
