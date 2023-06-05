import 'package:analyzer/dart/element/element.dart';
import 'package:mockito/mockito.dart';
import 'package:rx_mvvm_builder/src/constructor/constructor_generator.dart';
import 'package:test/test.dart';

class FakeConstructorElement extends Fake implements ConstructorElement {
  final String constructor;

  FakeConstructorElement(this.constructor);
  @override
  String toString() {
    return constructor;
  }
}

void main() {
  group('Params', () {
    test('Should extract constructor params', () {
      final constructor = FakeConstructorElement('Test(int a, int b);');

      final generator = ConstructorGenerator(constructor);
      expect(generator.params(), 'int a, int b');
    });

    test('Should extract constructor named params', () {
      final constructor =
          FakeConstructorElement('Test({ required int a, bool? b});');

      final generator = ConstructorGenerator(constructor);
      expect(generator.params(), '{ required int a, bool? b}');
    });
  });
}
