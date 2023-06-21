import 'package:analyzer/dart/element/element.dart';
import 'package:oxidized/oxidized.dart';
import 'package:rx_mvvm_annotations/rx_mvvm_annoations.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:source_gen/source_gen.dart';

import 'property_annotation.dart';

class OutputPropertyValidator implements BuilderValidator {
  final Property property;

  OutputPropertyValidator(this.property);

  @override
  Option<Object> value() {
    return Some(property);
  }

  @override
  Result<bool, Error> validate() {
    if (property.type.contains('EventEmitter')) {
      return const Ok(true);
    }

    return Err(InvalidGenerationSourceError(
      '`@Output` on property "${property.name}" - Output must be of type EventEmitter',
      element: property.field,
    ));
  }
}

class OutputPropertyBind implements PropertyBindEvent {
  final Property property;

  OutputPropertyBind._(this.property);
  factory OutputPropertyBind(Property property) {
    final validator = OutputPropertyValidator(property);

    if (validator.validate() case Err(error: final error)) {
      throw error;
    }

    return OutputPropertyBind._(property);
  }

  @override
  String binds() {
    return '${property.name}.subscribe((value) => widget.${property.bind}(value));';
  }

  @override
  String dispose() {
    return '${property.name}.close();';
  }
}

class OutputBinds implements PropertyBindEvent {
  final List<OutputPropertyBind> properties;

  OutputBinds._(this.properties);
  const OutputBinds.empyt() : properties = const [];

  factory OutputBinds(ClassElement element) {
    const checker = TypeChecker.fromRuntime(Output);
    final properties = element.fields
        .map((field) => PropertyAnnotation(field, checker))
        .where((property) => property.defined())
        .map((field) => OutputPropertyBind(field.property()))
        .toList();

    return OutputBinds._(properties);
  }

  @override
  String binds() {
    return properties.map((property) => property.binds()).join('\n');
  }

  @override
  String dispose() {
    return properties.map((property) => property.dispose()).join('\n');
  }
}
