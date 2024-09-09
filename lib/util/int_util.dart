extension IntExtention on int {
  int compareToNullable(int? other) {
    return other == null ? 0 : compareTo(other);
  }
}
