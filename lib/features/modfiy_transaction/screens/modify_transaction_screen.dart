import 'package:ewallet/models/transaction.dart';
import 'package:ewallet/shared/app_validators.dart';
import 'package:ewallet/state/state_container.dart';
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
  ModifyMode modifyMode = ModifyMode.add;
  final FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isInit = false;
  int? _id;
  String _title = 'Pénzmozgás hozzáadása';
  String _buttonText = 'Hozzáadás';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _id = ModalRoute
          .of(context)!
          .settings
          .arguments as int?;
      if (_id != null) {
        final transaction = StateContainer.of(context).findTransactionById(
            _id!);
        _transactionType = transaction.type;
        _date = transaction.date;
        _amount = transaction.amount;
        _description = transaction.description;

        if (_transactionType == TransactionType.expense) {
          _amount *= -1;
        }


        modifyMode = ModifyMode.edit;
        _title = 'Pénzmozgás módosítása';
        _buttonText = 'Módosítás';
      }
      _isInit = true;
    }
  }


  _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    switch (modifyMode) {
      case ModifyMode.add:
        StateContainer.of(context).addTransaction(description: _description,
            amount: _amount,
            type: _transactionType,
            date: _date);
        break;
      case ModifyMode.edit:
        StateContainer.of(context).editTransaction(id: _id!,
            description: _description,
            amount: _amount,
            type: _transactionType,
            date: _date);
        break;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Theme(
          data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.white),
          child: Form(
            key: _formKey,
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
                initialValue: '$_amount',
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
                initialValue: _description,
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
                  onPressed: _submitForm, child: Text(_buttonText)),
            ]),
          ),
        ),
      ),
    );
  }
}

enum ModifyMode { add, edit }
