import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';

import 'command_execution_type.dart';

class CommandResult implements CommandTypeDefinition {
  final String _type;
  final bool hasResult;
  final CommandExecutionType execution;

  CommandResult(this._type, this.hasResult, this.execution);

  CommandResult.from(MethodElement method)
      : _type = method.returnType.getDisplayString(withNullability: true),
        hasResult = method.returnType is! VoidType,
        execution = CommandExecutionType.from(method.returnType);
  CommandResult.sync(this._type)
      : execution = CommandExecutionType.sync,
        hasResult = _type != 'void';
  CommandResult.async(this._type)
      : execution = CommandExecutionType.async,
        hasResult = _type != 'void';
  CommandResult.stream(this._type)
      : execution = CommandExecutionType.stream,
        hasResult = _type != 'void';
  const CommandResult.empty()
      : _type = 'void',
        hasResult = false,
        execution = CommandExecutionType.sync;

  @override
  String type() {
    return switch (execution) {
      CommandExecutionType.async =>
        _type.replaceFirst('Future<', '').replaceFirst('>', ''),
      CommandExecutionType.stream =>
        _type.replaceFirst('Stream<', '').replaceFirst('>', ''),
      CommandExecutionType.sync => _type,
    };
  }

  @override
  String definition() {
    return hasResult ? '' : 'NoResult';
  }
}
