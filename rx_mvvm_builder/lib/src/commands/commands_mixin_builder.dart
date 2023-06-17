import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_annotations/rx_mvvm_annoations.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:rx_mvvm_builder/src/utils/name.dart';
import 'package:source_gen/source_gen.dart';

import 'command_generator.dart';

class CommandsMixinBuilder implements MvvmMixin {
  final ClassElement element;
  final List<CommandGenerator> commands;

  @override
  String get name => '_${Name.from(element).base()}Commands';

  const CommandsMixinBuilder._(this.element, this.commands);
  const CommandsMixinBuilder.from(this.element, this.commands);

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
