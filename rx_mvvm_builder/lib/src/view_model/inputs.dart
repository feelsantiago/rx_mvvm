import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_annotations/input.dart';
import 'package:rx_mvvm_builder/src/view_model/property_annotation.dart';
import 'package:source_gen/source_gen.dart';

class Inputs {
  final List<PropertyAnnotation> properties;

  Inputs._(this.properties);
  factory Inputs(ClassElement element) {
    const checker = TypeChecker.fromRuntime(Input);
    final properties = element.fields
        .map((field) => PropertyAnnotation(field, checker))
        .where((property) => property.defined())
        .toList();

    return Inputs._(properties);
  }

  String bind() {
    return properties
        .map((field) => '${field.property()} = widget.${field.property()};')
        .join('\n');
  }
}
