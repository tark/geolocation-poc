
extension StringExtention on String {
  String capitalize() {
    if (isEmpty) {
      return '';
    }
    return substring(0, 1).toUpperCase() + substring(1);
  }

  String last4Symbols() {
    if (length < 4) {
      return this;
    }
    return substring(length - 4, length);
  }

  String firstLetter() {
    return isEmpty ? '' : substring(0, 1);
  }

  bool isNumeric() {
    if (isEmpty) {
      return false;
    }

    return double.tryParse(this) != null;
  }

  bool containsLowerCase(String? query) {
    if (query == null || query.isEmpty) {
      return true;
    }

    return toLowerCase().contains(query.toLowerCase());
  }
}
