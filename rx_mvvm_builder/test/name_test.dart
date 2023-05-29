import 'package:rx_mvvm_builder/src/name.dart';
import 'package:test/test.dart';

void main() {
  group('Name', () {
    test('Should derive builder name', () {
      final name = Name('TestViewModel');
      final name1 = Name('Test_View_Model');
      final name2 = Name('testviewmodel');
      final name3 = Name('test_view_model');
      final name4 = Name('view_model_test');

      expect(name.generate(), 'Test');
      expect(name1.generate(), 'Test');
      expect(name2.generate(), 'Test');
      expect(name3.generate(), 'Test');
      expect(name4.generate(), 'Test');
    });
  });
}
