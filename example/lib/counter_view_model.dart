import 'package:rx_mvvm/rx_mvvm.dart';

part 'counter_view_model.g.dart';

@ViewModel()
class CounterViewModel with _CounterCommands {
  int counter = 0;

  CounterViewModel._();
  factory CounterViewModel() = _Counter;

  @Command()
  int _add() {
    counter += 1;
    return counter;
  }

  @Command()
  Stream<int> _generate() {
    return Stream.value(0);
  }

  @Command()
  Future<void> _remove(int value) async {}
}
