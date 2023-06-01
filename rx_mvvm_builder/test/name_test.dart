import 'package:rx_mvvm_builder/src/utils/name.dart';
import 'package:test/test.dart';

void main() {
  group('Name', () {
    test('Should remove view model from the name', () {
      final name1 = Name('TestViewModel');
      final name2 = Name('TestViewmodel');
      final name3 = Name('TestAgainViewModel');

      expect(name1.base(), 'Test');
      expect(name2.base(), 'Test');
      expect(name3.base(), 'TestAgain');
    });

    test('Should return method name', () {
      final name = Name('test');
      expect(name.base(), 'Test');
    });

    test('Sould return method name without private identifier', () {
      final name = Name('_test');
      expect(name.original, 'test');
    });
  });
}
