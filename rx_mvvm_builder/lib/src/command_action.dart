import 'package:rx_mvvm_builder/src/interfaces.dart';

import 'command_execution_type.dart';
import 'command_param.dart';
import 'command_result.dart';
import 'name.dart';

abstract class CommandAction implements CommandActionBuilder {
  final Name action;
  final CommandParam param;
  final CommandResult result;
  final CommandAnnotationDefinition annotation;

  CommandAction(
    this.action,
    this.param,
    this.result,
    this.annotation,
  );

  factory CommandAction.create(
    Name action,
    CommandParam param,
    CommandResult result,
    CommandAnnotationDefinition annotation,
    CommandExecutionType execution,
  ) {
    return switch (result.execution) {
      CommandExecutionType.stream =>
        CommandStreamAction(action, param, result, annotation),
      _ => CommandDefaultAction(action, param, result, annotation, execution),
    };
  }

  String options() {
    return switch (annotation.exist()) {
      true => ', ${annotation.options()},',
      false => '',
    };
  }
}

class CommandDefaultAction extends CommandAction {
  final CommandExecutionType execution;

  CommandDefaultAction(
    super.action,
    super.param,
    super.result,
    super.annotation,
    this.execution,
  );

  @override
  String generate() {
    return 'RxCommand.create${execution.alias}${param.definition()}${result.definition()}(super._${action.original}${options()})';
  }
}

class CommandStreamAction extends CommandAction {
  CommandStreamAction(
    super.action,
    super.param,
    super.result,
    super.annotation,
  );

  @override
  String generate() {
    final input = switch (param.hasParam) {
      true => 'param',
      false => '_',
    };

    final parameter = switch (param.hasParam) {
      true => 'param',
      false => '',
    };

    return 'RxCommand.create${result.execution.alias}(($input) => super._${action.original}($parameter)${options()})';
  }
}
