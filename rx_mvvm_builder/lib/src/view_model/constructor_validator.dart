import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';
import 'package:oxidized/oxidized.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:source_gen/source_gen.dart';

sealed class ConstructorValidatorBase
    implements BuilderValidator<ConstructorElement> {
  final ClassElement element;
  final Option<ConstructorElement> constructor;

  const ConstructorValidatorBase(this.element, this.constructor);

  @override
  Option<ConstructorElement> value() {
    return constructor;
  }
}

final class UnamedConstructorValidator extends ConstructorValidatorBase
    implements BuilderValidator<ConstructorElement> {
  const UnamedConstructorValidator._(super.element, super.constructor);
  factory UnamedConstructorValidator(ClassElement element) {
    final unamed = element.constructors
        .firstWhereOrNull((constructor) => constructor.name.isEmpty);
    return UnamedConstructorValidator._(element, Option.from(unamed));
  }

  @override
  Result<bool, Error> validate() {
    return constructor
        .okOrElse(() => InvalidGenerationSourceError(
              '`@ViewModel` must provide a unamed factory constructor.',
              element: element,
            ))
        .andThen<bool>((constructor) {
      return switch (constructor.isFactory) {
        true => const Ok(true),
        false => Err(
            InvalidGenerationSourceError(
              '`@ViewModel` unamed constructor must be a factory',
              element: constructor,
            ),
          )
      };
    });
  }
}

final class PrivateConstructorValidator extends ConstructorValidatorBase {
  const PrivateConstructorValidator._(super.element, super.constructor);
  factory PrivateConstructorValidator(ClassElement element) {
    final private = element.constructors
        .firstWhereOrNull((constructor) => constructor.name == '_');
    return PrivateConstructorValidator._(element, Option.from(private));
  }

  @override
  Result<bool, Error> validate() {
    return constructor
        .okOrElse(() => InvalidGenerationSourceError(
              '`@ViewModel` must provide a private named constructor `${element.name}._()` without params',
              element: element,
            ))
        .andThen<bool>((constructor) {
      return switch (constructor.parameters.isEmpty) {
        true => const Ok(true),
        false => Err(
            InvalidGenerationSourceError(
              '`@ViewModel` private constructor cannot have params',
              element: constructor,
            ),
          )
      };
    });
  }
}

final class ConstructorValidator {
  final BuilderValidator<ConstructorElement> unamed;
  final BuilderValidator<ConstructorElement> private;

  const ConstructorValidator._(this.unamed, this.private);

  factory ConstructorValidator(ClassElement element) {
    final unamed = UnamedConstructorValidator(element);
    final private = PrivateConstructorValidator(element);

    return ConstructorValidator._(unamed, private);
  }

  Option<ConstructorElement> constructor() {
    return unamed.value();
  }

  Result<bool, Error> verify() {
    return [unamed, private]
        .map((validator) => validator.validate())
        .firstWhere(
          (validation) => validation.isErr(),
          orElse: () => const Ok(true),
        );
  }
}
