class AppValidators {
  static bool required (String? value ) {
    return value == null || value.isEmpty;
  }

  static bool isNumber (String? value) {
    return value != null && num.tryParse(value) == null;
  }

  static bool nonNegative (String? value) {
    if (value != null) {
      num number = num.tryParse(value) ?? 0;
      return number <= 0;
    } else {
      return true;
    }
  }

  static bool largerThen (String? value, num limit) {
    if (value != null) {
      num number = num.tryParse(value) ?? 0;
      return number > limit;
    } else {
      return true;
    }
  }
}