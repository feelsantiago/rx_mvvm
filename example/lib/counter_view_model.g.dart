// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_view_model.dart';

// **************************************************************************
// ViewModelGenerator
// **************************************************************************

class _ViewModelBase
    with ViewModelBase, _InputsMixin, _CounterCommands, _CounterConstructor {
  @override
  void binds(dynamic widget) {
    myVariable = widget.myVariable;
  }

  @override
  @mustCallSuper
  Future<void> onDispose() async {
    await super.onDispose();
    onAdd.dispose();
  }
}

class _Counter extends CounterViewModel {
  _Counter(Service service) : super._() {
    _onAdd = RxCommand.createSyncNoParam(
      super._add,
      debugName: "Test",
      emitInitialCommandResult: false,
      emitsLastValueToNewSubscriptions: false,
    );
    onAdd = CommandEvents(_onAdd);

    _service = service;
  }
}

mixin _CounterConstructor {
  // ignore: unused_field
  late final Service _service;
}

mixin _InputsMixin {
  late int myVariable;
}

mixin _CounterCommands {
  late final RxCommand<void, int> _onAdd;
  late final CommandEvents<void, int> onAdd;

  void add() => _onAdd();
}
