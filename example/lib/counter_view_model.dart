import 'package:rx_mvvm/rx_mvvm.dart';

part 'counter_view_model.g.dart';

@ViewModel()
class CounterViewModel with _CounterCommands {
  @Command(debugName: 'Counter')
  void _add() {}

  void _canCount() {}
}
