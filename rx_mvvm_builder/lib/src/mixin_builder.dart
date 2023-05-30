import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_builder/src/command_generator.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:rx_mvvm_builder/src/name.dart';

class MixinBuilder implements MvvBuilder {
  final ClassElement element;
  final List<CommandGenerator> commands;

  String get name => '_${Name.from(element).mixin()}';

  MixinBuilder(this.element, this.commands);

  @override
  String write() {
    return '''
        mixin $name {
          ${commands.map((command) => command.definition()).join('\n')}         
          ${commands.map((command) => command.action()).join('\n')}         
        }
    ''';
  }
}
