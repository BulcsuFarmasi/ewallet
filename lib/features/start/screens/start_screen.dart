import 'package:ewallet/features/overview/screens/overview_screen.dart';
import 'package:ewallet/shared/app_validators.dart';
import 'package:ewallet/state/state_container.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _formKey = GlobalKey<FormState>();

  double? totalAmount;

  void _sumbitForm() {
    if(!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    StateContainer.of(context).modifyTotalAmount(totalAmount!);
    Navigator.of(context).pushReplacementNamed(OverviewScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Szia!',
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Hogy el tudjuk kezdeni, kérjük add meg mennyi pénz van a pénztárcában',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
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
                onSaved: (String? value) {
                  if (value != null) {
                    totalAmount = double.tryParse(value);
                  }
                },

              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _sumbitForm,
                child: const Text('Kezdés'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
