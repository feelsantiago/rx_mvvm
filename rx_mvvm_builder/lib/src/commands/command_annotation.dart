import 'package:analyzer/dart/constant/value.dart';
import 'package:oxidized/oxidized.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';

class CommandAnnotation implements CommandAnnotationDefinition {
  final Option<DartObject> annotation;

  CommandAnnotation(DartObject? annotation)
      : annotation = Option.from(annotation);
  const CommandAnnotation.empty() : annotation = const None();

  @override
  String debugName() {
    final debug = annotation
        .andThen((param) => Option.from(param.getField('debugName')))
        .andThen((field) => Option.from(field.toStringValue()));

    return switch (debug) {
      Some(some: final value) => 'debugName: "$value"',
      None() => '',
    };
  }

  @override
  String emitInitialValue() {
    final initial = annotation
        .andThen((param) => Option.from(param.getField('emitInitialValue')))
        .andThen((field) => Option.from(field.toBoolValue()));

    return switch (initial) {
      Some(some: final value) => 'emitInitialCommandResult: $value',
      None() => '',
    };
  }

  @override
  String emitLastValue() {
    final last = annotation
        .andThen((param) => Option.from(param.getField('emitLastValue')))
        .andThen((field) => Option.from(field.toBoolValue()));

    return switch (last) {
      Some(some: final value) => 'emitsLastValueToNewSubscriptions: $value',
      None() => '',
    };
  }

  @override
  String restriction() {
    final restriction = annotation
        .andThen((param) => Option.from(param.getField('restriction')))
        .andThen((field) => Option.from(field.toStringValue()));

    return switch (restriction) {
      Some(some: final value) => 'restriction: super.$value',
      None() => '',
    };
  }

  @override
  String options() {
    return [
      debugName(),
      emitInitialValue(),
      emitLastValue(),
      restriction(),
    ].where((value) => value.isNotEmpty).join(', ');
  }

  @override
  bool exist() {
    return annotation.isSome();
  }
}
