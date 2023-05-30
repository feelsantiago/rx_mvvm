import 'package:rx_mvvm_builder/src/command_generator.dart';
import 'package:rx_mvvm_builder/src/command_param.dart';
import 'package:rx_mvvm_builder/src/command_result.dart';
import 'package:rx_mvvm_builder/src/name.dart';
import 'package:test/test.dart';

void main() {
  group('CommandGenerator', () {
    group('Definition', () {
      test('Should generate command definition - No Param - No Result', () {
        final command = CommandGenerator(
          name: Name('test'),
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
          name: Name('test'),
          isAsync: false,
          result: CommandResult.sync('String'),
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
          name: Name('test'),
          isAsync: false,
          result: CommandResult.sync('String'),
          param: CommandParam.type('String'),
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
          name: Name('test'),
          isAsync: false,
          result: CommandResult.async('Future<String>'),
          param: CommandParam.type('String'),
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
          name: Name('test'),
          isAsync: false,
          result: CommandResult.stream('Stream<String>'),
          param: CommandParam.type('String'),
        );

        final result = '''
        late final RxCommand<String, String> _onTest;
        late final CommandEvents<String, String> onTest;
      '''
            .replaceAll(' ', '');

        expect(command.definition().replaceAll(' ', ''), result);
      });
    });

    group('Action', () {
      test('Should generate action with param', () {
        final command = CommandGenerator(
          name: Name('test'),
          result: CommandResult.sync('String'),
          param: CommandParam.type('String'),
        );

        final result =
            'void test(String param) => _onTest(param);\n'.replaceAll(' ', '');
        expect(command.action().replaceAll(' ', ''), result);
      });

      test('Should generate action without param', () {
        final command = CommandGenerator(
          name: Name('test'),
          result: CommandResult.sync('String'),
        );

        final result = 'void test() => _onTest();\n'.replaceAll(' ', '');
        expect(command.action().replaceAll(' ', ''), result);
      });
    });

    group('Initialization', () {
      group('Sync', () {
        test('Should intialize command with no param and no return', () {
          final command = CommandGenerator(
            name: Name('test'),
          );

          final result = '''
            _onTest = RxCommand.createSyncNoParamNoResult(super.test);
            onTest = CommandEvents(_onTest);
          '''
              .replaceAll(' ', '');

          expect(command.initialization().replaceAll(' ', ''), result);
        });

        test('Should intialize command with no param', () {
          final command = CommandGenerator(
            name: Name('test'),
            result: CommandResult.sync('String'),
          );

          final result = '''
            _onTest = RxCommand.createSyncNoParam(super.test);
            onTest = CommandEvents(_onTest);
          '''
              .replaceAll(' ', '');

          expect(command.initialization().replaceAll(' ', ''), result);
        });

        test('Should intialize command', () {
          final command = CommandGenerator(
            name: Name('test'),
            result: CommandResult.sync('String'),
            param: CommandParam.type('String'),
          );

          final result = '''
            _onTest = RxCommand.createSync(super.test);
            onTest = CommandEvents(_onTest);
          '''
              .replaceAll(' ', '');

          expect(command.initialization().replaceAll(' ', ''), result);
        });
      });

      group('Async', () {
        test('Should intialize command with no param and no return', () {
          final command = CommandGenerator(
            isAsync: true,
            name: Name('test'),
          );

          final result = '''
            _onTest = RxCommand.createAsyncNoParamNoResult(super.test);
            onTest = CommandEvents(_onTest);
          '''
              .replaceAll(' ', '');

          expect(command.initialization().replaceAll(' ', ''), result);
        });

        test('Should intialize command with no param', () {
          final command = CommandGenerator(
            name: Name('test'),
            isAsync: true,
            result: CommandResult.sync('String'),
          );

          final result = '''
            _onTest = RxCommand.createAsyncNoParam(super.test);
            onTest = CommandEvents(_onTest);
          '''
              .replaceAll(' ', '');

          expect(command.initialization().replaceAll(' ', ''), result);
        });

        test('Should intialize command', () {
          final command = CommandGenerator(
            name: Name('test'),
            isAsync: true,
            result: CommandResult.sync('String'),
            param: CommandParam.type('String'),
          );

          final result = '''
            _onTest = RxCommand.createAsync(super.test);
            onTest = CommandEvents(_onTest);
          '''
              .replaceAll(' ', '');

          expect(command.initialization().replaceAll(' ', ''), result);
        });
      });
    });
  });
}
