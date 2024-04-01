import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_builder/src/binds/input_binds.dart';
import 'package:rx_mvvm_builder/src/binds/output_binds.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:rx_mvvm_builder/src/utils/name.dart';

class ViewModelBuilder implements MvvmBuilder {
  final ClassElement element;
  final ConstructorBuilder constructor;
  final PropertyBind inputs;
  final PropertyBindEvent outputs;
  final List<MvvmMixin> mixins;

  @override
  String get name => '_${Name.from(element).base()}';

  const ViewModelBuilder(
    this.element, {
    required this.constructor,
    this.inputs = const InputBinds.empyt(),
    this.outputs = const OutputBinds.empyt(),
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

          ${outputs.binds()} 
        }

        @override
        Future<void> close() async {
          await super.close();

          ${outputs.dispose()}

          ${mixins.map((mixin) => mixin.dispose()).join('\n')}
        }
      }
    ''';
  }
}
