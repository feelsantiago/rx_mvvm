import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:rx_mvvm/rx_mvvm.dart';
import 'package:source_gen/source_gen.dart';

import 'class_builder.dart';
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

    final rxcommands = CommandsMixinBuilder(element);
    final builder = ClassBuilder(
      element,
      mixins: [rxcommands /*, injectable mixin*/],
    );

    return '''
      ${builder.write()}
      ${rxcommands.write()}
    ''';
  }
}
