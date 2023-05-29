import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm/rx_mvvm.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:rx_mvvm_builder/src/name.dart';
import 'package:source_gen/source_gen.dart';

class MixinBuilder implements MvvBuilder {
  final ClassElement element;

  String get name => '_${Name.from(element).mixin()}';

  MixinBuilder(this.element);

  @override
  String write() {
    const checker = TypeChecker.fromRuntime(Command);

    return '''
        mixin $name {

        }
    ''';
  }
}
