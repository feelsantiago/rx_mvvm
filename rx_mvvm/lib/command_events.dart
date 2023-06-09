import 'dart:async';

import 'package:rx_command/rx_command.dart';

class CommandEvents<TParam, TResult> {
  final RxCommand<TParam, TResult> command;

  late final Stream<TResult> values;
  late final Stream<CommandResult<TParam, TResult>> results;
  late final Stream exceptions;
  late final Stream<bool> executing;
  late final Stream<bool> canExecute;

  late final StreamSubscription _subscription;

  CommandEvents(this.command) {
    values = command;
    results = command.results;
    executing = command.isExecuting;
    exceptions = command.thrownExceptions;
    canExecute = command.canExecute;

    _subscription = exceptions.listen((error) {
      // ignore: avoid_print
      print(error);
    });
  }

  void dispose() {
    _subscription.cancel();
    command.dispose();
  }
}
