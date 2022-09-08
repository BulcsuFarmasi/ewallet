import 'package:ewallet/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:ewallet/app.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final applicationDocumentsDirectory = await getApplicationDocumentsDirectory();
  Hive.init(applicationDocumentsDirectory.path);
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  initializeDateFormatting('hu');
  runApp(const App());
}
