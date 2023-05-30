import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:rx_mvvm/rx_mvvm.dart';
import 'package:source_gen/source_gen.dart';

import 'class_builder.dart';
import 'command_generator.dart';
import 'commands_mixin_builder.dart';

class ViewModelGenerator extends GeneratorForAnnotation<ViewModel> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement || element is EnumElement) {
      throw InvalidGenerationSourceError(
        '`@ViewModel` can only be used on classes.',
        element: element,
      );
    }

    const checker = TypeChecker.fromRuntime(Command);
    final commands = element.methods
        .map((method) => CommandGenerator.from(method, checker))
        .where((command) => command.defined())
        .toList();

    final rxcommands = CommandsMixinBuilder(element, commands);
    final builder = ClassBuilder(
      element,
      commands,
      mixins: [rxcommands /*, injectable mixin*/],
    );

    return '''
      ${builder.write()}
      ${rxcommands.write()}
    ''';
  }
}
