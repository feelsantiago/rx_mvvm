import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_annotations/input.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:source_gen/source_gen.dart';

import 'property_annotation.dart';

class InputBinds implements PropertyBind {
  final List<Property> properties;

  InputBinds._(this.properties);
  const InputBinds.empyt() : properties = const [];

  factory InputBinds(ClassElement element) {
    const checker = TypeChecker.fromRuntime(Input);
    final properties = element.fields
        .map((field) => PropertyAnnotation(field, checker))
        .where((property) => property.defined())
        .map((field) => field.property())
        .toList();

    return InputBinds._(properties);
  }

  @override
  String binds() {
    return properties
        .map((property) => '${property.name} = widget.${property.bind};')
        .join('\n');
  }
}
