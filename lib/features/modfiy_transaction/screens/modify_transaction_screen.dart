import 'package:ewallet/models/transaction.dart';
import 'package:flutter/material.dart';

class ModifyTranactionScreen extends StatefulWidget {
  const ModifyTranactionScreen({Key? key}) : super(key: key);

  static const routeName = '/modify_transaction';

  @override
  State<ModifyTranactionScreen> createState() => _ModifyTranactionScreenState();
}

class _ModifyTranactionScreenState extends State<ModifyTranactionScreen> {
  TransactionType transactionType = TransactionType.expense;

  DateTime date = DateTime.now();

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
                      groupValue: transactionType,
                      onChanged: (TransactionType? newTransactionType) {
                        setState(() {
                          if (newTransactionType != null) {
                            transactionType = newTransactionType;
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
                      groupValue: transactionType,
                      onChanged: (TransactionType? newTransactionType) {
                        setState(() {
                          if (newTransactionType != null) {
                            transactionType = newTransactionType;
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
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Leírás'),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    date.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(date.year - 5),
                          lastDate: DateTime(date.year + 5));
                      if (selectedDate != null) {
                        setState(() {
                          date = selectedDate;
                        });
                      }
                    },
                    icon: const Icon(Icons.calendar_month),
                    color: Colors.white,
                  )
                ],
              ),
              ElevatedButton(onPressed: () {}, child: const Text('Hozzáadás')),
            ]),
          ),
        ),
      ),
    );
  }
}
