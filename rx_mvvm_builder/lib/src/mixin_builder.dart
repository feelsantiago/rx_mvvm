import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';
import 'package:rx_mvvm_builder/src/name.dart';

class MixinBuilder implements MvvBuilder {
  final ClassElement element;

  MixinBuilder(this.element);

  @override
  String write() {
    final name = Name.from(element);

    return '''
        mixin _${name.generate()}Commands {

        }
    ''';
  }
}
