extension BooleanExtention on bool {
  int compareTo(bool? other) {
    if (this == other) {
      return 0;
    } else if (this) {
      return 1;
    } else {
      return -1;
    }
  }
}