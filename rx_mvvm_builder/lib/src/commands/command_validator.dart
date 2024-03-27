import 'package:analyzer/dart/element/element.dart';
import 'package:oxidized/oxidized.dart';
import 'package:rx_mvvm_builder/src/commands/command_annotation.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:source_gen/source_gen.dart';

class CommandValidator implements BuilderValidator<MethodElement> {
  final MethodElement method;
  final CommandAnnotation annotation;

  CommandValidator(this.method, this.annotation);

  @override
  Result<bool, Exception> validate() {
    if (annotation.exist()) {
      if (method.parameters.length > 1) {
        return Err(InvalidGenerationSourceError(
          '`@Command` on method "${method.name}" - Commands must have only one parameter',
          element: method,
        ));
      }

      if (!method.isPrivate) {
        return Err(InvalidGenerationSourceError(
          '`@Command` on method "${method.name}" - Commands actions should be private',
          element: method,
        ));
      }
    }

    return const Ok(true);
  }

  @override
  Option<MethodElement> value() {
    return Some(method);
  }
}
