// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_view_model.dart';

// **************************************************************************
// ViewModelGenerator
// **************************************************************************

class _Counter extends CounterViewModel with _CounterCommands {
  _Counter() : super._() {
    _onAdd = RxCommand.createSyncNoParam(
      super._add,
      debugName: "Counter",
      emitInitialCommandResult: false,
      emitsLastValueToNewSubscriptions: false,
    );
    onAdd = CommandEvents(_onAdd);
  }

  void dispose() {
    onAdd.dispose();
  }
}

mixin _CounterCommands {
  late final RxCommand<void, int> _onAdd;
  late final CommandEvents<void, int> onAdd;

  void add() => _onAdd();
}
