import 'package:analyzer/dart/element/element.dart';

import 'string_extensions.dart';

class Name {
  final String _name;
  String get original => _name;

  Name(String name) : _name = name.removePrivateIdentifier();
  Name.from(ClassElement element)
      : _name = element.name.removePrivateIdentifier();
  Name.method(MethodElement method)
      : _name = method.name.removePrivateIdentifier();

  String base() {
    return _name
        .captilizeFirst()
        .replaceFirst('ViewModel', '')
        .replaceFirst('Viewmodel', '');
  }

  String command() {
    return 'on${_name.captilizeFirst()}';
  }
}
