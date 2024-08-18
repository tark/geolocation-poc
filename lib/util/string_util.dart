bool isEmpty(String? value) {
  return value == null || value.isEmpty;
}

bool isNotEmpty(String? value) {
  return !isEmpty(value);
}