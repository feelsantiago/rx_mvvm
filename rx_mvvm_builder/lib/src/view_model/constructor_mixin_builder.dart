import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:rx_mvvm_builder/src/utils/name.dart';
import 'package:rx_mvvm_builder/src/view_model/constructor_validator.dart';

class ConstructorMixinBuilder implements MvvmMixin {
  final ClassElement element;

  const ConstructorMixinBuilder._(this.element);
  const ConstructorMixinBuilder.from(this.element);

  factory ConstructorMixinBuilder(ClassElement element) {
    ConstructorValidator(element).verify();
    return ConstructorMixinBuilder._(element);
  }

  @override
  String get name => '_${Name.from(element).base()}Constructor';

  @override
  String dispose() {
    return '';
  }

  @override
  String initialization() {
    // TODO: implement initialization
    throw UnimplementedError();
  }

  @override
  String write() {
    // TODO: implement write
    throw UnimplementedError();
  }
}
