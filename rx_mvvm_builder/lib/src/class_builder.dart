import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:rx_mvvm_builder/src/name.dart';

import 'command_generator.dart';

class ClassBuilder implements MvvmBuilder {
  final ClassElement element;
  final List<CommandGenerator> commands;
  final List<MvvmBuilder> mixins;

  @override
  String get name => '_${Name.from(element).base()}';

  ClassBuilder(
    this.element,
    this.commands, {
    this.mixins = const [],
  });

  @override
  String write() {
    return '''
        class $name extends ${element.name} with ${mixins.map((mixin) => mixin.name).join(', ')} {
           
            $name(): super._() {
                ${commands.map((command) => command.initialization()).join('\n')}
            }

            void dispose() {
                ${commands.map((command) => command.dispose()).join('\n')}
            }
        }
    ''';
  }
}
