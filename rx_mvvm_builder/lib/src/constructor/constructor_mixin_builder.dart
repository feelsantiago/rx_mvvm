import 'package:analyzer/dart/element/element.dart';
import 'package:oxidized/oxidized.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:rx_mvvm_builder/src/utils/name.dart';

import 'constructor_validator.dart';

class ConstructorMixinBuilder implements MvvmMixin {
  final ClassElement element;
  final ConstructorElement constructor;

  const ConstructorMixinBuilder._(this.element, this.constructor);
  const ConstructorMixinBuilder.from(this.element, this.constructor);

  factory ConstructorMixinBuilder(ClassElement element) {
    final validator = ConstructorValidator(element);
    final validation = validator.verify();

    if (validation case Err(error: final error)) {
      throw error;
    }

    final constructor = validator.constructor().unwrap();
    return ConstructorMixinBuilder._(element, constructor);
  }

  @override
  String get name => '_${Name.from(element).base()}Constructor';

  @override
  String dispose() {
    return '';
  }

  @override
  String initialization() {
    return constructor.parameters
        .map((param) => '_${param.name} = ${param.name};')
        .join('\n');
  }

  @override
  String write() {
    return '''
      mixin $name {
        ${constructor.parameters.map((param) => 'late final ${param.type.toString()} _${param.name};').join('\n')}
      }
    ''';
  }
}
