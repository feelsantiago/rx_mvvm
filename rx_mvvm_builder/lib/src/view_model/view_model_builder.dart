import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:rx_mvvm_builder/src/utils/name.dart';
import 'package:rx_mvvm_builder/src/view_model/inputs_mixin_builder.dart';

class ViewModelBuilder implements MvvmBuilder {
  final ClassElement element;
  final ConstructorBuilder constructor;
  final MvvmMixin inputs;
  final List<MvvmMixin> mixins;

  @override
  String get name => '_${Name.from(element).base()}';

  const ViewModelBuilder(
    this.element,
    this.constructor, {
    this.inputs = const InputsMixinBuilder.empyt(),
    this.mixins = const [],
  });

  @override
  String write() {
    // TODO: Define inputs propeties direclty in the view model base
    return '''
      class _ViewModelBase with ViewModelBase, ${inputs.name}, ${mixins.map((mixin) => mixin.name).join(', ')} {
        @override
        void binds(dynamic widget) {
          ${inputs.initialization()} 
        }

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
