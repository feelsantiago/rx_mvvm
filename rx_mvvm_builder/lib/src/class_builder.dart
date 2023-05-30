import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';

import 'command_generator.dart';

class ClassBuilder implements MvvmBuilder {
  final ClassElement element;
  final List<CommandGenerator> commands;
  final List<MvvmBuilder> mixins;

  ClassBuilder(
    this.element,
    this.commands, {
    this.mixins = const [],
  });

  @override
  String write() {
    return '';
  }
}
