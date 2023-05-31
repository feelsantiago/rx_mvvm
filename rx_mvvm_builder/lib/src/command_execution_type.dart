import 'package:analyzer/dart/element/type.dart';

enum CommandExecutionType {
  async(alias: 'Async'),
  sync(alias: 'Sync'),
  stream(alias: 'FromStream');

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
