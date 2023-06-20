import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_annotations/input.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:rx_mvvm_builder/src/view_model/property_annotation.dart';
import 'package:source_gen/source_gen.dart';

// TODO: This dont need to be a mixin
class InputsMixinBuilder implements MvvmMixin {
  final List<Property> properties;

  @override
  String get name => '_InputsMixin';

  InputsMixinBuilder._(this.properties);
  const InputsMixinBuilder.empyt() : properties = const [];

  factory InputsMixinBuilder(ClassElement element) {
    const checker = TypeChecker.fromRuntime(Input);
    final properties = element.fields
        .map((field) => PropertyAnnotation(field, checker))
        .where((property) => property.defined())
        .map((field) => field.property())
        .toList();

    return InputsMixinBuilder._(properties);
  }

  @override
  String dispose() {
    return '';
  }

  @override
  String initialization() {
    return properties
        .map((property) => '${property.name} = widget.${property.name};')
        .join('\n');
  }

  @override
  String write() {
    return '''
      mixin $name {
        ${properties.map((property) => property.toString()).join('\n')}
      }
    ''';
  }
}
