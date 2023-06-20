import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:rx_mvvm_builder/src/utils/name.dart';
import 'package:rx_mvvm_builder/src/view_model/input_binds.dart';

class ViewModelBuilder implements MvvmBuilder {
  final ClassElement element;
  final ConstructorBuilder constructor;
  final PropertyBind inputs;
  final List<MvvmMixin> mixins;

  @override
  String get name => '_${Name.from(element).base()}';

  const ViewModelBuilder(
    this.element, {
    required this.constructor,
    this.inputs = const InputBinds.empyt(),
    this.mixins = const [],
  });

  @override
  String write() {
    return '''
      class _ViewModelBase with ViewModelBase, ${mixins.map((mixin) => mixin.name).join(', ')} {
      }

      class $name extends ${element.name} {
        $name(${constructor.params()}): super._() {
          ${mixins.map((mixin) => mixin.initialization()).join('\n')}
        }

        @override
        void binds(dynamic widget) {
          ${inputs.binds()} 
        }

        @override
        @mustCallSuper
        Future<void> onDispose() async {
          await super.onDispose();
          ${mixins.map((mixin) => mixin.dispose()).join('\n')}
        }
      }
    ''';
  }
}
