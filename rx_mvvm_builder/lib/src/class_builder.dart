import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:rx_mvvm_builder/src/name.dart';

class ClassBuilder implements MvvmBuilder {
  final ClassElement element;
  final List<MvvmMixin> mixins;

  @override
  String get name => '_${Name.from(element).base()}';

  const ClassBuilder(
    this.element, {
    this.mixins = const [],
  });

  @override
  String write() {
    return '''
        class $name extends ${element.name} with ${mixins.map((mixin) => mixin.name).join(', ')} {
           
            $name(): super._() {
              ${mixins.map((mixin) => mixin.initialization()).join('\n')}
            }

            void dispose() {
              ${mixins.map((mixin) => mixin.dispose()).join('\n')}
            }
        }
    ''';
  }
}
