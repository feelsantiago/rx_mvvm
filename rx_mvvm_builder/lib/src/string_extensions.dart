extension StringUtils on String {
  String captilizeFirst() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String removeSpaces() {
    return replaceAll(' ', '');
  }

  String removePrivateIdentifier() {
    if (this[0] == '_') {
      return replaceFirst('_', '');
    }

    return this;
  }
}
