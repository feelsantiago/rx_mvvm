import 'package:analyzer/dart/element/element.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rx_mvvm_builder/src/commands/command_generator.dart';
import 'package:rx_mvvm_builder/src/commands/commands_mixin_builder.dart';
import 'package:rx_mvvm_builder/src/utils/name.dart';
import 'package:rx_mvvm_builder/src/utils/string_extensions.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([MockSpec<ClassElement>()])
import 'commands_mixin_builder_test.mocks.dart';

void main() {
  group('MixinBuilder', () {
    test('Should generate command mixin class', () {
      final commands = [
        CommandGenerator(name: Name('test')),
        CommandGenerator(name: Name('other')),
      ];

      final element = MockClassElement();
      when(element.name).thenReturn('TestViewModel');

      final mixin = CommandsMixinBuilder.from(element, commands);
      final result = '''
        mixin _TestCommands {
            late final RxCommand<void, void> _onTest;
            late final CommandEvents<void, void> onTest;
            late final RxCommand<void, void> _onOther;
            late final CommandEvents<void, void> onOther;

            void test() => _onTest();
            void other() => _onOther();
            
        }
        '''
          .removeSpaces();

      expect(mixin.write().removeSpaces(), result);
      verify(element.name).called(1);
    });
  });
}
