import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rx_command/rx_command.dart';

class CommandEvents<TParam, TResult> {
  final RxCommand<TParam, TResult> command;

  late final Stream<TResult> values;
  late final Stream<CommandResult<TParam, TResult>> results;
  late final Stream exceptions;
  late final Stream<bool> executing;

  late final StreamSubscription _subscription;

  CommandEvents(this.command) {
    values = command;
    results = command.results;
    executing = command.isExecuting;
    exceptions = command.thrownExceptions;

    _subscription = executing.listen((error) {
      if (!kReleaseMode) {
        // ignore: avoid_print
        print(error);
      }
    });
  }

  void dispose() {
    _subscription.cancel();
    command.dispose();
  }
}
