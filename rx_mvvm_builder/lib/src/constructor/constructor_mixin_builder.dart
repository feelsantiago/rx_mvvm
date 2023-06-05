import 'package:analyzer/dart/element/element.dart';
import 'package:oxidized/oxidized.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:rx_mvvm_builder/src/utils/name.dart';

import 'constructor_generator.dart';
import 'constructor_validator.dart';

class ConstructorMixinBuilder implements MvvmMixin {
  final ClassElement element;
  final ConstructorBuilder constructor;

  const ConstructorMixinBuilder._(this.element, this.constructor);
  const ConstructorMixinBuilder.from(this.element, this.constructor);

  factory ConstructorMixinBuilder(ClassElement element) {
    final validator = ConstructorValidator(element);
    final validation = validator.verify();

    if (validation case Err(error: final error)) {
      throw error;
    }

    final constructor = validator.constructor().unwrap();
    return ConstructorMixinBuilder._(
      element,
      ConstructorGenerator(constructor),
    );
  }

  @override
  String get name => '_${Name.from(element).base()}Constructor';

  @override
  String dispose() {
    return '';
  }

  @override
  String initialization() {
    return constructor.initialization();
  }

  @override
  String write() {
    return '''
      mixin $name {
        ${constructor.definition()}
      }
    ''';
  }
}
