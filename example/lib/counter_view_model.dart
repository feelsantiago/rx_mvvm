import 'package:rx_mvvm/rx_mvvm.dart';

part 'counter_view_model.g.dart';

@ViewModel()
class CounterViewModel with _CounterCommands {
  int counter = 0;

  CounterViewModel._();
  factory CounterViewModel() = _Counter;

  @Command(debugName: 'Counter')
  int _add() {
    counter += 1;
    return counter;
  }
}
