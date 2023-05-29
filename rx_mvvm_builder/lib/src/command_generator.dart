import 'package:analyzer/dart/element/element.dart';

import 'command_execution_type.dart';
import 'command_return.dart';
import 'name.dart';

class CommandGenerator {
  final Name name;

  final bool hasParam;

  final CommandExecutionType execution;
  final String paramType;
  final CommandReturn returnType;

  CommandGenerator({
    required String name,
    this.hasParam = false,
    this.paramType = 'void',
    this.returnType = const CommandReturn.empty(),
    bool isAsync = false,
  })  : name = Name(name),
        execution = CommandExecutionType.isAsync(isAsync);

  factory CommandGenerator.from(MethodElement method) {
    // TODO: save checker object
    final hasParam = method.parameters.isNotEmpty;

    if (method.parameters.length > 1) {
      throw Exception('Commands must have only one parameter');
    }

    // TODO: refactor param
    final param = method.parameters.firstOrNull;

    return CommandGenerator(
      name: method.name,
      isAsync: method.isAsynchronous,
      hasParam: hasParam,
      paramType: param?.type.getDisplayString(withNullability: true) ?? 'void',
      returnType: CommandReturn.from(method),
    );
  }

  String definition() {
    final action = name.command();

    return '''
      late final RxCommand<$paramType, ${returnType.type()}> _$action;
      late final CommandEvents<$paramType, ${returnType.type()}> $action;
    ''';
  }

  String action() {
    final action = name.original;
    return '''
      void $action($paramType param) => _${name.command()}(param);
    ''';
  }

  String initialization() {
    final action = name.command();
    final param = hasParam ? '' : 'NoParam';

    return '''
      _$action = RxCommand.create${execution.alias}$param${returnType.definition()}(super.${name.original});
      $action = CommandEvents(_$action);
    ''';
  }
}
