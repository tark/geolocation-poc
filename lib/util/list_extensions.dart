extension ListExtention<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inPlace = true]) {
    final ids = <dynamic>{};
    final list = inPlace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }

  E? firstOrNull() {
    return isEmpty ? null : first;
  }

  E? firstWhereOrNull(bool Function(E element) test) {
    return where(test).toList().firstOrNull();
  }

  bool containsWhere(bool Function(E element) test) {
    return where(test).isNotEmpty;
  }

  List<E> addOrReplaceWhere(E newElement, bool Function(E element) test) {
    final index = indexWhere(test);
    if (index >= 0) {
      this[index] = newElement;
    } else {
      add(newElement);
    }
    return this;
  }

  List<E> replaceWhere(E newElement, bool Function(E element) test) {
    final index = indexWhere(test);
    if (index >= 0) {
      this[index] = newElement;
    }
    return this;
  }

  bool elementsEqual() {
    return isEmpty || every((e) => e == first);
  }
}
