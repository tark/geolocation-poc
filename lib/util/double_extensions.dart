extension DoubleExtention on double {
  double loopInRange(int range) {
    return this < range ? this : this - range;
  }
}
