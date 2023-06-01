import 'package:rx_mvvm_builder/src/commands/command_generator.dart';
import 'package:rx_mvvm_builder/src/commands/command_param.dart';
import 'package:rx_mvvm_builder/src/commands/command_result.dart';
import 'package:rx_mvvm_builder/src/utils/name.dart';
import 'package:rx_mvvm_builder/src/utils/string_extensions.dart';
import 'package:test/test.dart';

import 'utils/fake_command_annotation.dart';

void main() {
  group('CommandGenerator', () {
    group('Definition', () {
      test('Should generate command definition - No Param - No Result', () {
        final command = CommandGenerator(
          name: Name('_test'),
          isAsync: false,
          annotation: const FakeCommandAnnotation(),
        );

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
          result: const CommandResult.sync('String'),
          annotation: const FakeCommandAnnotation(),
        );

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
          result: const CommandResult.sync('String'),
          param: const CommandParam.type('String'),
          annotation: const FakeCommandAnnotation(),
        );

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
          result: const CommandResult.async('Future<String>'),
          param: const CommandParam.type('String'),
          annotation: const FakeCommandAnnotation(),
        );

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
          result: const CommandResult.stream('Stream<String>'),
          param: const CommandParam.type('String'),
          annotation: const FakeCommandAnnotation(),
        );

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
          result: const CommandResult.sync('String'),
          param: const CommandParam.type('String'),
          annotation: const FakeCommandAnnotation(),
        );

        final result =
            'void test(String param) => _onTest(param);\n'.removeSpaces();
        expect(command.action().removeSpaces(), result);
      });

      test('Should generate action without param', () {
        final command = CommandGenerator(
          name: Name('_test'),
          result: const CommandResult.sync('String'),
          annotation: const FakeCommandAnnotation(),
        );

        final result = 'void test() => _onTest();\n'.removeSpaces();
        expect(command.action().removeSpaces(), result);
      });
    });

    group('Initialization', () {
      test('Should initialize with parameters', () {
        final command = CommandGenerator(
          name: Name('test'),
          annotation: const FakeCommandAnnotation(
            fOptions: 'debugName: true, restriction: super.other',
            fExist: true,
          ),
        );

        final result = '''
            _onTest = RxCommand.createSyncNoParamNoResult(super._test, debugName: true, restriction: super.other,);
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
            _onTest = RxCommand.createSyncNoParamNoResult(super._test);
            onTest = CommandEvents(_onTest);
          '''
              .removeSpaces();

          expect(command.initialization().removeSpaces(), result);
        });

        test('Should intialize command with no param', () {
          final command = CommandGenerator(
            name: Name('_test'),
            result: const CommandResult.sync('String'),
          );

          final result = '''
            _onTest = RxCommand.createSyncNoParam(super._test);
            onTest = CommandEvents(_onTest);
          '''
              .removeSpaces();

          expect(command.initialization().removeSpaces(), result);
        });

        test('Should intialize command', () {
          final command = CommandGenerator(
            name: Name('_test'),
            result: const CommandResult.sync('String'),
            param: const CommandParam.type('String'),
            annotation: const FakeCommandAnnotation(),
          );

          final result = '''
            _onTest = RxCommand.createSync(super._test);
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
            annotation: const FakeCommandAnnotation(),
          );

          final result = '''
            _onTest = RxCommand.createAsyncNoParamNoResult(super._test);
            onTest = CommandEvents(_onTest);
          '''
              .removeSpaces();

          expect(command.initialization().removeSpaces(), result);
        });

        test('Should intialize command with no param', () {
          final command = CommandGenerator(
            name: Name('_test'),
            isAsync: true,
            result: const CommandResult.sync('String'),
            annotation: const FakeCommandAnnotation(),
          );

          final result = '''
            _onTest = RxCommand.createAsyncNoParam(super._test);
            onTest = CommandEvents(_onTest);
          '''
              .removeSpaces();

          expect(command.initialization().removeSpaces(), result);
        });

        test('Should intialize command', () {
          final command = CommandGenerator(
            name: Name('_test'),
            isAsync: true,
            result: const CommandResult.sync('String'),
            param: const CommandParam.type('String'),
            annotation: const FakeCommandAnnotation(),
          );

          final result = '''
            _onTest = RxCommand.createAsync(super._test);
            onTest = CommandEvents(_onTest);
          '''
              .removeSpaces();

          expect(command.initialization().removeSpaces(), result);
        });
      });

      group('Stream', () {
        test('Should initialize from stream with param', () {
          final command = CommandGenerator(
            name: Name('_test'),
            result: const CommandResult.stream('String'),
            param: const CommandParam.type('String'),
            annotation: const FakeCommandAnnotation(),
          );

          final result = '''
            _onTest = RxCommand.createFromStream((param) => super._test(param));
            onTest = CommandEvents(_onTest);
          '''
              .removeSpaces();

          expect(command.initialization().removeSpaces(), result);
        });

        test('Should initialize from stream without param', () {
          final command = CommandGenerator(
            name: Name('_test'),
            result: const CommandResult.stream('String'),
            annotation: const FakeCommandAnnotation(),
          );

          final result = '''
            _onTest = RxCommand.createFromStream((_) => super._test());
            onTest = CommandEvents(_onTest);
          '''
              .removeSpaces();

          expect(command.initialization().removeSpaces(), result);
        });
      });
    });

    group('Dispose', () {
      test('Should create dispose call', () {
        final command = CommandGenerator(
          name: Name('_test'),
          annotation: const FakeCommandAnnotation(),
        );

        const result = 'onTest.dispose();';
        expect(command.dispose(), result);
      });
    });
  });
}
