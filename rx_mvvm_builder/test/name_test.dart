import 'package:rx_mvvm_builder/src/name.dart';
import 'package:test/test.dart';

void main() {
  group('Name', () {
    test('Should remove view model from the name', () {
      final name1 = Name('TestViewModel');
      final name2 = Name('TestViewmodel');
      final name3 = Name('TestAgainViewModel');

      expect(name1.sanitize(), 'Test');
      expect(name2.sanitize(), 'Test');
      expect(name3.sanitize(), 'TestAgain');
    });

    test('Should return method name', () {
      final name = Name('test');
      expect(name.sanitize(), 'Test');
    });

    test('Should create mixin name', () {
      final name = Name('TestViewModel');
      expect(name.mixin(), 'TestCommands');
    });
  });
}
