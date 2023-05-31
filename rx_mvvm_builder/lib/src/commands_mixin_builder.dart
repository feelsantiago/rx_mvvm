import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm/annotations.dart';
import 'package:rx_mvvm_builder/src/command_generator.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:rx_mvvm_builder/src/name.dart';
import 'package:source_gen/source_gen.dart';

class CommandsMixinBuilder implements MvvmMixin {
  final ClassElement element;
  final List<CommandGenerator> commands;

  @override
  String get name => '_${Name.from(element).base()}Commands';

  CommandsMixinBuilder._(this.element, this.commands);
  CommandsMixinBuilder.from(this.element, this.commands);

  factory CommandsMixinBuilder(ClassElement element) {
    const checker = TypeChecker.fromRuntime(Command);
    final commands = element.methods
        .map((method) => CommandGenerator.from(method, checker))
        .where((command) => command.defined())
        .toList();

    return CommandsMixinBuilder._(element, commands);
  }

  @override
  String initialization() {
    return commands.map((command) => command.initialization()).join('\n');
  }

  @override
  String dispose() {
    return commands.map((command) => command.dispose()).join('\n');
  }

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
