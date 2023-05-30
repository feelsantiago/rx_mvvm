// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_view_model.dart';

// **************************************************************************
// ViewModelGenerator
// **************************************************************************

class _Counter extends CounterViewModel with _CounterCommands {
  _Counter() : super._() {
    _onAdd = RxCommand.createSyncNoParamNoResult(super.add,
        debugName: "Counter", emitsLastValueToNewSubscriptions: false);
    onAdd = CommandEvents(_onAdd);

    _onRemove = RxCommand.createSyncNoParamNoResult(super.remove,
        emitsLastValueToNewSubscriptions: false);
    onRemove = CommandEvents(_onRemove);
  }

  void dispose() {
    onAdd.dispose();
    onRemove.dispose();
  }
}

mixin _CounterCommands {
  late final RxCommand<void, void> _onAdd;
  late final CommandEvents<void, void> onAdd;
  late final RxCommand<void, void> _onRemove;
  late final CommandEvents<void, void> onRemove;

  void add() => _onAdd();
  void remove() => _onRemove();
}
