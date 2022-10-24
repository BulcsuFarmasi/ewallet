import 'package:hive/hive.dart';

class TotalAmountHandler {
  Future<void> open() async {
    await Hive.openBox(boxName);
  }

  double? getTotalAmount() {
    return Hive.box(boxName).get(boxName);
  }

  void modifyTotalAmount(double totalAmount) {
    Hive.box(boxName).put(boxName, totalAmount);
  }

  static const boxName = 'totalAmount';
}
