import 'package:analyzer/dart/element/element.dart';

import 'string_extensions.dart';

class Name {
  final String _name;

  String get original => _name;

  Name(this._name);
  Name.from(ClassElement element) : _name = element.name;
  Name.method(MethodElement method) : _name = method.name;

  String sanitize() {
    return _name
        .captilizeFirst()
        .replaceFirst('ViewModel', '')
        .replaceFirst('Viewmodel', '');
  }

  String mixin() {
    return '${sanitize()}Commands';
  }

  String command() {
    return 'on${_name.captilizeFirst()}';
  }
}
