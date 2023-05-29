import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_builder/src/command_param.dart';

import 'command_execution_type.dart';
import 'command_result.dart';
import 'name.dart';

class CommandGenerator {
  final Name name;
  final CommandExecutionType execution;
  final CommandParam param;
  final CommandResult result;

  CommandGenerator({
    required this.name,
    this.param = const CommandParam.empty(),
    this.result = const CommandResult.empty(),
    bool isAsync = false,
  }) : execution = CommandExecutionType.isAsync(isAsync);

  factory CommandGenerator.from(MethodElement method) {
    // TODO: save checker object

    if (method.parameters.length > 1) {
      throw Exception('Commands must have only one parameter');
    }

    // TODO: Pass more info in the error
    if (!method.isPrivate) {
      throw Exception('Commands actions should be private');
    }

    return CommandGenerator(
      name: Name.method(method),
      isAsync: method.isAsynchronous,
      param: CommandParam.from(method),
      result: CommandResult.from(method),
    );
  }

  String definition() {
    final action = name.command();

    return '''
      late final RxCommand<${param.type()}, ${result.type()}> _$action;
      late final CommandEvents<${param.type()}, ${result.type()}> $action;
    ''';
  }

  String action() {
    final action = name.original;
    return '''
      void $action(${param.type()} param) => _${name.command()}(param);
    ''';
  }

  String initialization() {
    final action = name.command();

    return '''
      _$action = RxCommand.create${execution.alias}${param.definition()}${result.definition()}(super.${name.original});
      $action = CommandEvents(_$action);
    ''';
  }
}
