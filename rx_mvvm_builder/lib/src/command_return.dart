import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'command_execution_type.dart';

class CommandReturn {
  final String _type;
  final bool hasReturn;
  final CommandExecutionType execution;

  CommandReturn(this._type, this.hasReturn, this.execution);

  CommandReturn.from(MethodElement method)
      : _type = method.returnType.getDisplayString(withNullability: true),
        hasReturn = method.returnType is! VoidType,
        execution = CommandExecutionType.from(method.returnType);
  CommandReturn.sync(this._type)
      : execution = CommandExecutionType.sync,
        hasReturn = _type != 'void';
  CommandReturn.async(this._type)
      : execution = CommandExecutionType.async,
        hasReturn = _type != 'void';
  CommandReturn.stream(this._type)
      : execution = CommandExecutionType.stream,
        hasReturn = _type != 'void';
  const CommandReturn.empty()
      : _type = 'void',
        hasReturn = false,
        execution = CommandExecutionType.sync;

  String type() {
    return switch (execution) {
      CommandExecutionType.async =>
        _type.replaceFirst('Future<', '').replaceFirst('>', ''),
      CommandExecutionType.stream =>
        _type.replaceFirst('Stream<', '').replaceFirst('>', ''),
      CommandExecutionType.sync => _type,
    };
  }

  String definition() {
    return hasReturn ? '' : 'NoReturn';
  }
}
