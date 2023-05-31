import 'package:analyzer/dart/constant/value.dart';

import 'interfaces.dart';

class CommandAnnotation implements CommandAnnotationDefinition {
  final DartObject? annotation;

  const CommandAnnotation(this.annotation);
  const CommandAnnotation.empty() : annotation = null;

  @override
  String debugName() {
    final debugName = annotation!.getField('debugName');

    if (debugName != null && !debugName.isNull) {
      return 'debugName: "${debugName.toStringValue()!}"';
    }

    return '';
  }

  @override
  String emitInitialValue() {
    final emitInitialValue = annotation!.getField('emitInitialValue');

    if (emitInitialValue != null && !emitInitialValue.isNull) {
      final value = emitInitialValue.toBoolValue() ?? false;
      return 'emitInitialCommandResult: $value';
    }

    return '';
  }

  @override
  String emitLastValue() {
    final emitLastValue = annotation!.getField('emitLastValue');

    if (emitLastValue != null && !emitLastValue.isNull) {
      final value = emitLastValue.toBoolValue() ?? false;
      return 'emitsLastValueToNewSubscriptions: $value';
    }

    return '';
  }

  @override
  String restriction() {
    final restriction = annotation!.getField('restriction');

    if (restriction != null && !restriction.isNull) {
      return 'restriction: super.${restriction.toStringValue()!}';
    }

    return '';
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
    return annotation != null;
  }
}
