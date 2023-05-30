import 'package:rx_mvvm/rx_mvvm.dart';

part 'counter_view_model.g.dart';

@ViewModel()
class CounterViewModel with _CounterCommands {
  CounterViewModel._();
  factory CounterViewModel() = _Counter;

  @Command(debugName: 'Counter')
  void _add() {}

  @Command()
  void _remove() {}

  void _canCount() {}
}
