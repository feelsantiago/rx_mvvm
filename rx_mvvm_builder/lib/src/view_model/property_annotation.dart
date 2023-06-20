import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:oxidized/oxidized.dart';
import 'package:source_gen/source_gen.dart';

class PropertyAnnotation {
  FieldElement field;
  Option<DartObject> annotation;

  PropertyAnnotation._(this.field, DartObject? annotation)
      : annotation = Option.from(annotation);
  factory PropertyAnnotation(FieldElement field, TypeChecker checker) {
    return PropertyAnnotation._(field, checker.firstAnnotationOfExact(field));
  }

  String property() {
    final property = annotation
        .andThen((param) => Option.from(param.getField('property')))
        .andThen((field) => Option.from(field.toStringValue()));

    return switch (property) {
      Some(some: final value) => value,
      None() => field.name,
    };
  }

  bool defined() {
    return annotation.isSome();
  }
}
