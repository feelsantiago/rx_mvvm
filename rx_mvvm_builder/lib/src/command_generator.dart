import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'name.dart';

enum CommandExecutionType {
  async(alias: 'Async'),
  sync(alias: 'Sync'),
  stream(alias: 'Stream');

  final String alias;

  const CommandExecutionType({required this.alias});

  factory CommandExecutionType.from(DartType type) {
    if (type.isDartAsyncFuture) {
      return CommandExecutionType.async;
    }

    if (type.isDartAsyncStream) {
      return CommandExecutionType.stream;
    }

    return CommandExecutionType.sync;
  }

  factory CommandExecutionType.isAsync(bool isAsync) {
    if (isAsync) {
      return CommandExecutionType.async;
    }

    return CommandExecutionType.sync;
  }
}

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
