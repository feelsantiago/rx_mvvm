import 'package:analyzer/dart/element/element.dart';

class Name {
  final String name;

  Name(String name) : name = name.toLowerCase().replaceAll('_', '');
  Name.from(ClassElement element)
      : name = element.name.toLowerCase().replaceAll('_', '');

  bool _hasVmSufix() {
    return name.contains('viewmodel');
  }

  String generate() {
    if (_hasVmSufix()) {
      final base = name.replaceFirst('viewmodel', '');

      return '${base[0].toUpperCase()}${base.substring(1)}';
    }

    return name;
  }
}
