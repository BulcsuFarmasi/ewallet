import 'package:ewallet/models/transaction.dart';
import 'package:ewallet/shared/app_validators.dart';
import 'package:flutter/material.dart';

class ModifyTranactionScreen extends StatefulWidget {
  const ModifyTranactionScreen({Key? key}) : super(key: key);

  static const routeName = '/modify_transaction';

  @override
  State<ModifyTranactionScreen> createState() => _ModifyTranactionScreenState();
}

class _ModifyTranactionScreenState extends State<ModifyTranactionScreen> {
  TransactionType _transactionType = TransactionType.expense;
  DateTime _date = DateTime.now();
  double _amount = 0;
  String _description = '';
  FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();


  _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pénzmozgás módosítása'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Theme(
          data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.white),
          child: Form(
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<TransactionType>(
                      activeColor: Colors.white,
                      value: TransactionType.expense,
                      groupValue: _transactionType,
                      onChanged: (TransactionType? newTransactionType) {
                        setState(() {
                          if (newTransactionType != null) {
                            _transactionType = newTransactionType;
                          }
                        });
                      },
                      title: const Text(
                        'Kiadás',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<TransactionType>(
                      value: TransactionType.income,
                      activeColor: Colors.white,
                      groupValue: _transactionType,
                      onChanged: (TransactionType? newTransactionType) {
                        setState(() {
                          if (newTransactionType != null) {
                            _transactionType = newTransactionType;
                          }
                        });
                      },
                      title: const Text('Bevétel',
                          style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Összeg'),
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  String? errorMessage;
                  if (AppValidators.required(value)) {
                    errorMessage = 'Kérjük töltsd ki a mezőt';
                  } else if (AppValidators.isNumber(value)) {
                    errorMessage = 'Kérjük számot adj meg';
                  } else if (AppValidators.nonNegative(value)) {
                    errorMessage = 'Kérjük ne negatív számot adj meg';
                  }
                  return errorMessage;
                },
                onEditingComplete: () {
                  _focusNode.nextFocus();
                },
                onSaved: (String? value) {
                  if (value != null) {
                    _amount = double.tryParse(value)!;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                focusNode: _focusNode,
                validator: (String? value) {
                  String? errorMessage;
                  if (AppValidators.required(value)) {
                    errorMessage = 'Kérjük töltsd ki a mezőt';
                  }
                  return errorMessage;
                },
                decoration: const InputDecoration(hintText: 'Leírás'),
                onSaved: (String? value) {
                  if (value != null) {
                    _description = value;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    _date.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          firstDate: DateTime(_date.year - 5),
                          lastDate: DateTime(_date.year + 5));
                      if (selectedDate != null) {
                        setState(() {
                          _date = selectedDate;
                        });
                      }
                    },
                    icon: const Icon(Icons.calendar_month),
                    color: Colors.white,
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: _submitForm, child: const Text('Hozzáadás')),
            ]),
          ),
        ),
      ),
    );
  }
}
