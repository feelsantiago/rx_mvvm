import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_builder/src/command_generator.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:rx_mvvm_builder/src/name.dart';

class CommandsMixinBuilder implements MvvmBuilder {
  final ClassElement element;
  final List<CommandGenerator> commands;

  @override
  String get name => '_${Name.from(element).base()}Commands';

  CommandsMixinBuilder(this.element, this.commands);

  @override
  String write() {
    return '''
        mixin $name {
          ${commands.map((command) => command.definition()).join('')}         
          ${commands.map((command) => command.action()).join('')}         
        }
    ''';
  }
}
