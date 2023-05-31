// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_view_model.dart';

// **************************************************************************
// ViewModelGenerator
// **************************************************************************

class _Counter extends CounterViewModel with _CounterCommands {
  _Counter() : super._() {
    _onAdd = RxCommand.createSyncNoParam(
      super._add,
      emitInitialCommandResult: false,
      emitsLastValueToNewSubscriptions: false,
    );
    onAdd = CommandEvents(_onAdd);

    _onGenerate = RxCommand.createFromStream(
      (_) => super._generate(),
      emitInitialCommandResult: false,
      emitsLastValueToNewSubscriptions: false,
    );
    onGenerate = CommandEvents(_onGenerate);

    _onRemove = RxCommand.createAsync(
      super._remove,
      emitInitialCommandResult: false,
      emitsLastValueToNewSubscriptions: false,
    );
    onRemove = CommandEvents(_onRemove);
  }

  void dispose() {
    onAdd.dispose();
    onGenerate.dispose();
    onRemove.dispose();
  }
}

mixin _CounterCommands {
  late final RxCommand<void, int> _onAdd;
  late final CommandEvents<void, int> onAdd;
  late final RxCommand<void, int> _onGenerate;
  late final CommandEvents<void, int> onGenerate;
  late final RxCommand<int, void> _onRemove;
  late final CommandEvents<int, void> onRemove;

  void add() => _onAdd();
  void generate() => _onGenerate();
  void remove(int param) => _onRemove(param);
}
