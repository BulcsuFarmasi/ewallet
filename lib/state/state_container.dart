import 'package:ewallet/models/transaction.dart';
import 'package:ewallet/state/state_provider.dart';
import 'package:flutter/material.dart';

class StateContainer extends InheritedWidget {
  final double? totalAmount;
  final List<Transaction> transactions;
  final StateProviderState stateProviderState;

  const StateContainer({required this.totalAmount, required this.transactions, required this.stateProviderState, required super.child, super.key, });

  static StateProviderState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<StateContainer>()!.stateProviderState;

  @override
  bool updateShouldNotify(StateContainer oldWidget) {
    return totalAmount != oldWidget.totalAmount &&
        transactions != oldWidget.transactions;
  }
}
