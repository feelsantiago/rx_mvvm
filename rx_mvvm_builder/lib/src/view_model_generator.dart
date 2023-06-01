import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:rx_mvvm/rx_mvvm.dart';
import 'package:rx_mvvm_builder/src/view_model/constructor_mixin_builder.dart';
import 'package:source_gen/source_gen.dart';

import 'commands/commands_mixin_builder.dart';
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

    if (!element.isAbstract) {
      throw InvalidGenerationSourceError(
        '`@ViewModel` can only be used on abstract classes.',
        element: element,
      );
    }

    final commands = CommandsMixinBuilder(element);
    final constructors = ConstructorMixinBuilder(element);

    final viewModel = ViewModelBuilder(
      element,
      mixins: [commands /*, injectable mixin*/],
    );

    return '''
      ${viewModel.write()}
      ${commands.write()}
    ''';
  }
}
