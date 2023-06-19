import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:rx_mvvm_builder/src/utils/name.dart';

class ViewModelBuilder implements MvvmBuilder {
  final ClassElement element;
  final ConstructorBuilder constructor;
  final List<MvvmMixin> mixins;

  @override
  String get name => '_${Name.from(element).base()}';

  const ViewModelBuilder(
    this.element,
    this.constructor, {
    this.mixins = const [],
  });

  @override
  String write() {
    return '''
      class _ViewModelBase with ViewModelBase, ${mixins.map((mixin) => mixin.name).join(', ')} {
        @override
        @mustCallSuper
        Future<void> onDispose() async {
          await super.onDispose();
          ${mixins.map((mixin) => mixin.dispose()).join('\n')}
        }
      }

      class $name extends ${element.name} {
        $name(${constructor.params()}): super._() {
          ${mixins.map((mixin) => mixin.initialization()).join('\n')}
        }
      }
    ''';
  }
}
