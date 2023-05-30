import 'package:analyzer/dart/constant/value.dart';

abstract interface class CommandAnnotationDefinition {
  String emitInitialValue();
  String emitLastValue();
  String debugName();
  String restriction();
  String parameters();
  bool exist();
}

class CommandAnnotation implements CommandAnnotationDefinition {
  final DartObject? annotation;

  CommandAnnotation(this.annotation);
  const CommandAnnotation.empty() : annotation = null;

  @override
  String debugName() {
    final debugName = annotation!.getField('debugName');

    if (debugName != null) {
      return 'debugName: ${debugName.toStringValue()!}';
    }

    return '';
  }

  @override
  String emitInitialValue() {
    final emitInitialValue = annotation!.getField('emitInitialValue');

    if (emitInitialValue != null) {
      final value = emitInitialValue.toBoolValue() ?? false;
      return 'emitInitialCommandResult: $value';
    }

    return '';
  }

  @override
  String emitLastValue() {
    final emitLastValue = annotation!.getField('emitLasValue');

    if (emitLastValue != null) {
      final value = emitLastValue.toBoolValue() ?? false;
      return 'emitsLastValueToNewSubscriptions: $value';
    }

    return '';
  }

  @override
  String restriction() {
    final restriction = annotation!.getField('restriction');

    if (restriction != null) {
      return 'restriction: super.${restriction.toStringValue()!}';
    }

    return '';
  }

  @override
  String parameters() {
    return [
      debugName(),
      emitInitialValue(),
      emitLastValue(),
      restriction(),
    ].where((value) => value.isNotEmpty).join(', ');
  }

  @override
  bool exist() {
    return annotation != null;
  }
}
