// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_view_model.dart';

// **************************************************************************
// ViewModelGenerator
// **************************************************************************

class _Counter extends CounterViewModel
    with _CounterCommands, _CounterConstructor {
  _Counter(int a) : super._() {
    _onAdd = RxCommand.createSyncNoParam(
      super._add,
      debugName: "Test",
      emitInitialCommandResult: false,
      emitsLastValueToNewSubscriptions: false,
    );
    onAdd = CommandEvents(_onAdd);

    _onRandom = RxCommand.createFromStream(
      (_) => super._random(),
      emitInitialCommandResult: false,
      emitsLastValueToNewSubscriptions: false,
    );
    onRandom = CommandEvents(_onRandom);

    _a = a;
  }

  void dispose() {
    onAdd.dispose();
    onRandom.dispose();
  }
}

mixin _CounterConstructor {
  late final int _a;
}

mixin _CounterCommands {
  late final RxCommand<void, int> _onAdd;
  late final CommandEvents<void, int> onAdd;
  late final RxCommand<void, int> _onRandom;
  late final CommandEvents<void, int> onRandom;

  void add() => _onAdd();
  void random() => _onRandom();
}
