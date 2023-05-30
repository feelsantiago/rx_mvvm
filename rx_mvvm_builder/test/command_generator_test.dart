import 'package:rx_mvvm_builder/src/command_generator.dart';
import 'package:rx_mvvm_builder/src/command_param.dart';
import 'package:rx_mvvm_builder/src/command_result.dart';
import 'package:rx_mvvm_builder/src/name.dart';
import 'package:rx_mvvm_builder/src/string_extensions.dart';
import 'package:test/test.dart';

import 'utils/fake_command_annotation.dart';

void main() {
  group('CommandGenerator', () {
    group('Definition', () {
      test('Should generate command definition - No Param - No Result', () {
        final command = CommandGenerator(
            name: Name('_test'),
            isAsync: false,
            annotation: const FakeCommandAnnotation());

        final result = '''
        late final RxCommand<void, void> _onTest;
        late final CommandEvents<void, void> onTest;
      '''
            .removeSpaces();

        expect(command.definition().removeSpaces(), result);
      });

      test('Should generate command definition - No Param', () {
        final command = CommandGenerator(
            name: Name('_test'),
            isAsync: false,
            result: CommandResult.sync('String'),
            annotation: const FakeCommandAnnotation());

        final result = '''
        late final RxCommand<void, String> _onTest;
        late final CommandEvents<void, String> onTest;
      '''
            .removeSpaces();

        expect(command.definition().removeSpaces(), result);
      });

      test('Should generate command definition', () {
        final command = CommandGenerator(
            name: Name('_test'),
            isAsync: false,
            result: CommandResult.sync('String'),
            param: CommandParam.type('String'),
            annotation: const FakeCommandAnnotation());

        final result = '''
        late final RxCommand<String, String> _onTest;
        late final CommandEvents<String, String> onTest;
      '''
            .removeSpaces();

        expect(command.definition().removeSpaces(), result);
      });

      test('Should remove Future<> from return type on definition', () {
        final command = CommandGenerator(
            name: Name('_test'),
            isAsync: false,
            result: CommandResult.async('Future<String>'),
            param: CommandParam.type('String'),
            annotation: const FakeCommandAnnotation());

        final result = '''
        late final RxCommand<String, String> _onTest;
        late final CommandEvents<String, String> onTest;
      '''
            .removeSpaces();

        expect(command.definition().removeSpaces(), result);
      });

      test('Should remove Stream<> from return type on definition', () {
        final command = CommandGenerator(
            name: Name('_test'),
            isAsync: false,
            result: CommandResult.stream('Stream<String>'),
            param: CommandParam.type('String'),
            annotation: const FakeCommandAnnotation());

        final result = '''
        late final RxCommand<String, String> _onTest;
        late final CommandEvents<String, String> onTest;
      '''
            .removeSpaces();

        expect(command.definition().removeSpaces(), result);
      });
    });

    group('Action', () {
      test('Should generate action with param', () {
        final command = CommandGenerator(
            name: Name('_test'),
            result: CommandResult.sync('String'),
            param: CommandParam.type('String'),
            annotation: const FakeCommandAnnotation());

        final result =
            'void test(String param) => _onTest(param);\n'.removeSpaces();
        expect(command.action().removeSpaces(), result);
      });

      test('Should generate action without param', () {
        final command = CommandGenerator(
            name: Name('_test'),
            result: CommandResult.sync('String'),
            annotation: const FakeCommandAnnotation());

        final result = 'void test() => _onTest();\n'.removeSpaces();
        expect(command.action().removeSpaces(), result);
      });
    });

    group('Initialization', () {
      test('Should initialize with parameters', () {
        final command = CommandGenerator(
          name: Name('test'),
          annotation: const FakeCommandAnnotation(
            fParameter: 'debugName: true, restriction: super.other',
            fExist: true,
          ),
        );

        final result = '''
            _onTest = RxCommand.createSyncNoParamNoResult(super.test, debugName: true, restriction: super.other);
            onTest = CommandEvents(_onTest);
          '''
            .removeSpaces();

        expect(command.initialization().removeSpaces(), result);
      });

      group('Sync', () {
        test('Should intialize command with no param and no return', () {
          final command = CommandGenerator(
            name: Name('_test'),
          );

          final result = '''
            _onTest = RxCommand.createSyncNoParamNoResult(super.test);
            onTest = CommandEvents(_onTest);
          '''
              .removeSpaces();

          expect(command.initialization().removeSpaces(), result);
        });

        test('Should intialize command with no param', () {
          final command = CommandGenerator(
            name: Name('_test'),
            result: CommandResult.sync('String'),
          );

          final result = '''
            _onTest = RxCommand.createSyncNoParam(super.test);
            onTest = CommandEvents(_onTest);
          '''
              .removeSpaces();

          expect(command.initialization().removeSpaces(), result);
        });

        test('Should intialize command', () {
          final command = CommandGenerator(
              name: Name('_test'),
              result: CommandResult.sync('String'),
              param: CommandParam.type('String'),
              annotation: const FakeCommandAnnotation());

          final result = '''
            _onTest = RxCommand.createSync(super.test);
            onTest = CommandEvents(_onTest);
          '''
              .removeSpaces();

          expect(command.initialization().removeSpaces(), result);
        });
      });

      group('Async', () {
        test('Should intialize command with no param and no return', () {
          final command = CommandGenerator(
              isAsync: true,
              name: Name('_test'),
              annotation: const FakeCommandAnnotation());

          final result = '''
            _onTest = RxCommand.createAsyncNoParamNoResult(super.test);
            onTest = CommandEvents(_onTest);
          '''
              .removeSpaces();

          expect(command.initialization().removeSpaces(), result);
        });

        test('Should intialize command with no param', () {
          final command = CommandGenerator(
              name: Name('_test'),
              isAsync: true,
              result: CommandResult.sync('String'),
              annotation: const FakeCommandAnnotation());

          final result = '''
            _onTest = RxCommand.createAsyncNoParam(super.test);
            onTest = CommandEvents(_onTest);
          '''
              .removeSpaces();

          expect(command.initialization().removeSpaces(), result);
        });

        test('Should intialize command', () {
          final command = CommandGenerator(
              name: Name('_test'),
              isAsync: true,
              result: CommandResult.sync('String'),
              param: CommandParam.type('String'),
              annotation: const FakeCommandAnnotation());

          final result = '''
            _onTest = RxCommand.createAsync(super.test);
            onTest = CommandEvents(_onTest);
          '''
              .removeSpaces();

          expect(command.initialization().removeSpaces(), result);
        });
      });
    });
  });
}
