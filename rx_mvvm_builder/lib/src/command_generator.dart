import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_builder/src/command_action.dart';
import 'package:rx_mvvm_builder/src/command_param.dart';
import 'package:source_gen/source_gen.dart';

import 'command_annotation.dart';
import 'command_execution_type.dart';
import 'command_result.dart';
import 'interfaces.dart';
import 'name.dart';

class CommandGenerator implements CommandBuilder {
  final Name name;
  final CommandExecutionType execution;
  final CommandParam param;
  final CommandResult result;
  final CommandAnnotationDefinition annotation;

  CommandGenerator({
    required this.name,
    this.param = const CommandParam.empty(),
    this.result = const CommandResult.empty(),
    this.annotation = const CommandAnnotation.empty(),
    bool isAsync = false,
  }) : execution = CommandExecutionType.isAsync(isAsync);

  factory CommandGenerator.from(MethodElement method, TypeChecker command) {
    if (method.parameters.length > 1) {
      throw Exception(
          '`@Command` on method "${method.name}" - Commands must have only one parameter');
    }

    if (!method.isPrivate) {
      throw Exception(
        '`@Command` on method "${method.name}" - Commands actions should be private',
      );
    }

    return CommandGenerator(
      name: Name.method(method),
      isAsync: method.isAsynchronous,
      param: CommandParam.from(method),
      result: CommandResult.from(method),
      annotation: CommandAnnotation(command.firstAnnotationOfExact(method)),
    );
  }

  @override
  String definition() {
    final action = name.command();

    return '''
      late final RxCommand<${param.type()}, ${result.type()}> _$action;
      late final CommandEvents<${param.type()}, ${result.type()}> $action;
    ''';
  }

  @override
  String action() {
    final action = name.original;

    return switch (param.hasParam) {
      true =>
        'void $action(${param.type()} param) => _${name.command()}(param);\n',
      false => 'void $action() => _${name.command()}();\n',
    };
  }

  @override
  String initialization() {
    final action = name.command();
    final command =
        CommandAction.create(name, param, result, annotation, execution);

    return '''
      _$action = ${command.generate()};
      $action = CommandEvents(_$action);
    ''';
  }

  @override
  bool defined() {
    return annotation.exist();
  }

  @override
  String dispose() {
    return '${name.command()}.dispose();';
  }
}
