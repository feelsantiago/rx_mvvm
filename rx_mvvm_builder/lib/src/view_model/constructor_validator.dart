import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';

class UnamedConstructorValidator {
  final ConstructorElement? constructor;

  UnamedConstructorValidator(this.constructor);

  bool exist() {
    return constructor != null;
  }

  bool isFactory() {
    return exist() && constructor!.isFactory;
  }
}

class PrivateConstructorValidator {
  final ConstructorElement? constructor;

  PrivateConstructorValidator(this.constructor);

  bool exist() {
    return constructor != null;
  }

  bool hasParams() {
    return exist() && constructor!.parameters.isNotEmpty;
  }
}

class ConstructorValidator {
  final ClassElement element;
  final ConstructorElement? unamed;
  final ConstructorElement? private;

  const ConstructorValidator._(this.element, this.unamed, this.private);

  factory ConstructorValidator(ClassElement element) {
    final unamed = element.constructors
        .firstWhereOrNull((constructor) => constructor.name.isEmpty);
    final private = element.constructors
        .firstWhereOrNull((constructor) => constructor.name == '_');

    return ConstructorValidator._(element, unamed, private);
  }

  void verify() {
    final unamed = UnamedConstructorValidator(this.unamed);

    if (!unamed.exist()) {
      throw InvalidGenerationSourceError(
        '`@ViewModel` must provide a unamed factory constructor',
        element: element,
      );
    }

    if (!unamed.isFactory()) {
      throw InvalidGenerationSourceError(
        '`@ViewModel` unamed constructor must be a factory',
        element: this.unamed,
      );
    }

    final private = PrivateConstructorValidator(this.private);

    if (!private.exist()) {
      throw InvalidGenerationSourceError(
        '`@ViewModel` must provide a private named constructor `${element.name}._()` without params',
        element: element,
      );
    }

    if (private.hasParams()) {
      throw InvalidGenerationSourceError(
        '`@ViewModel` private constructor cannot have params',
        element: this.private,
      );
    }
  }
}
