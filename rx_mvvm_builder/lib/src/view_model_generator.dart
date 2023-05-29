import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:rx_mvvm/rx_mvvm.dart';
import 'package:rx_mvvm_builder/src/mixin_builder.dart';
import 'package:source_gen/source_gen.dart';

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

    final mixin = MixinBuilder(element);
    // final class = ClassBuilder(element, mixin.commands());

    return mixin.write();
  }
}
