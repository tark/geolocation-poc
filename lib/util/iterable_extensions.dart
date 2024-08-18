extension IterableExtention<E, Id> on Iterable<E> {
  E? firstOrNull() {
    return isEmpty ? null : first;
  }

  E? firstWhereOrNull(bool Function(E element) test) {
    return where(test).toList().firstOrNull();
  }

  bool containsWhere(bool Function(E element) test) {
    return where(test).isNotEmpty;
  }

  bool elementsEqual() {
    return isEmpty || every((e) => e == first);
  }
}
