import 'package:rx_mvvm_builder/src/command_generator.dart';
import 'package:rx_mvvm_builder/src/command_return.dart';
import 'package:test/test.dart';

void main() {
  group('CommandGenerator', () {
    test('Should generate command definition - No Param - No Result', () {
      final command = CommandGenerator(
        name: 'test',
        isAsync: false,
      );

      final result = '''
        late final RxCommand<void, void> _onTest;
        late final CommandEvents<void, void> onTest;
      '''
          .replaceAll(' ', '');

      expect(command.definition().replaceAll(' ', ''), result);
    });

    test('Should generate command definition - No Param', () {
      final command = CommandGenerator(
        name: 'test',
        isAsync: false,
        returnType: CommandReturn.sync('String'),
      );

      final result = '''
        late final RxCommand<void, String> _onTest;
        late final CommandEvents<void, String> onTest;
      '''
          .replaceAll(' ', '');

      expect(command.definition().replaceAll(' ', ''), result);
    });

    test('Should generate command definition', () {
      final command = CommandGenerator(
        name: 'test',
        isAsync: false,
        returnType: CommandReturn.sync('String'),
        hasParam: true,
        paramType: 'String',
      );

      final result = '''
        late final RxCommand<String, String> _onTest;
        late final CommandEvents<String, String> onTest;
      '''
          .replaceAll(' ', '');

      expect(command.definition().replaceAll(' ', ''), result);
    });

    test('Should remove Future<> from return type on definition', () {
      final command = CommandGenerator(
        name: 'test',
        isAsync: false,
        returnType: CommandReturn.async('Future<String>'),
        hasParam: true,
        paramType: 'String',
      );

      final result = '''
        late final RxCommand<String, String> _onTest;
        late final CommandEvents<String, String> onTest;
      '''
          .replaceAll(' ', '');

      expect(command.definition().replaceAll(' ', ''), result);
    });

    test('Should remove Stream<> from return type on definition', () {
      final command = CommandGenerator(
        name: 'test',
        isAsync: false,
        returnType: CommandReturn.stream('Stream<String>'),
        hasParam: true,
        paramType: 'String',
      );

      final result = '''
        late final RxCommand<String, String> _onTest;
        late final CommandEvents<String, String> onTest;
      '''
          .replaceAll(' ', '');

      expect(command.definition().replaceAll(' ', ''), result);
    });
  });
}
