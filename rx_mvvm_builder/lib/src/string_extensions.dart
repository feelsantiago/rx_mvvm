extension StringUtils on String {
  String captilizeFirst() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}