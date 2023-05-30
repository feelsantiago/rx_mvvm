@GenerateNiceMocks([MockSpec<DartObject>()])
import 'package:analyzer/dart/constant/value.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rx_mvvm_builder/src/command_annotation.dart';
import 'package:test/test.dart';

import 'command_annotation_test.mocks.dart';

void main() {
  group('CommandAnnotation', () {
    test('Should get debugName', () {
      final annotation = MockDartObject();
      final debugName = MockDartObject();

      when(debugName.toStringValue()).thenReturn('TestDebug');
      when(annotation.getField('debugName')).thenReturn(debugName);

      final command = CommandAnnotation(annotation);
      expect(command.debugName(), 'debugName: "TestDebug"');
    });

    test('Should get emitInitialValue', () {
      final annotation = MockDartObject();
      final emitInitialValue = MockDartObject();

      when(emitInitialValue.toBoolValue()).thenReturn(true);
      when(annotation.getField('emitInitialValue'))
          .thenReturn(emitInitialValue);

      final command = CommandAnnotation(annotation);
      expect(command.emitInitialValue(), 'emitInitialCommandResult: true');
    });

    test('Should get emitLastValue', () {
      final annotation = MockDartObject();
      final emitLastValue = MockDartObject();

      when(emitLastValue.toBoolValue()).thenReturn(false);
      when(annotation.getField('emitLastValue')).thenReturn(emitLastValue);

      final command = CommandAnnotation(annotation);
      expect(
          command.emitLastValue(), 'emitsLastValueToNewSubscriptions: false');
    });

    test('Should get restriction', () {
      final annotation = MockDartObject();
      final restriction = MockDartObject();

      when(restriction.toStringValue()).thenReturn('canExecute');
      when(annotation.getField('restriction')).thenReturn(restriction);

      final command = CommandAnnotation(annotation);
      expect(command.restriction(), 'restriction: super.canExecute');
    });

    test('Should get parameters', () {
      final annotation = MockDartObject();
      final debugName = MockDartObject();
      final restriction = MockDartObject();
      final emitLastValue = MockDartObject();
      final emitInitialValue = MockDartObject();

      when(emitInitialValue.toBoolValue()).thenReturn(true);
      when(annotation.getField('emitInitialValue'))
          .thenReturn(emitInitialValue);
      when(debugName.toStringValue()).thenReturn('TestDebug');
      when(annotation.getField('debugName')).thenReturn(debugName);
      when(restriction.toStringValue()).thenReturn('canExecute');
      when(annotation.getField('restriction')).thenReturn(restriction);
      when(emitLastValue.toBoolValue()).thenReturn(false);
      when(annotation.getField('emitLastValue')).thenReturn(emitLastValue);

      const result =
          'debugName: "TestDebug", emitInitialCommandResult: true, emitsLastValueToNewSubscriptions: false, restriction: super.canExecute';

      final command = CommandAnnotation(annotation);
      expect(command.parameters(), result);
    });
  });
}
