import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:rx_mvvm_annotations/rx_mvvm_annoations.dart';
import 'package:rx_mvvm_builder/src/view_model/input_binds.dart';
import 'package:source_gen/source_gen.dart';

import 'commands/commands_mixin_builder.dart';
import 'constructor/constructor_mixin_builder.dart';
import 'view_model/view_model_builder.dart';

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

    final commands = CommandsMixinBuilder(element);
    final dependencies = ConstructorMixinBuilder(element);
    final inputs = InputBinds(element);

    final viewModel = ViewModelBuilder(
      element,
      constructor: dependencies.constructor,
      inputs: inputs,
      mixins: [commands, dependencies],
    );

    return '''
      ${viewModel.write()}
      ${dependencies.write()}
      ${commands.write()}
    ''';
  }
}
