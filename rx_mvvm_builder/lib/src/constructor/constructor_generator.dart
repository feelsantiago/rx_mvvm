import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';

class ConstructorGenerator implements ConstructorBuilder {
  final ConstructorElement constructor;

  ConstructorGenerator(this.constructor);

  @override
  String definition() {
    return constructor.parameters
        .map((param) => 'late final ${param.type.toString()} _${param.name};')
        .join('\n');
  }

  @override
  String initialization() {
    return constructor.parameters
        .map((param) => '_${param.name} = ${param.name};')
        .join('\n');
  }

  @override
  String params() {
    final params = constructor.toString();
    final left = params.indexOf('(');

    final rest = params.substring(left + 1);
    final right = rest.indexOf(')');

    return rest.substring(0, right);
  }
}
