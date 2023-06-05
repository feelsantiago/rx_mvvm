import 'dart:math';

import 'package:rx_mvvm/rx_mvvm.dart';

part 'counter_view_model.g.dart';

@ViewModel()
abstract class CounterViewModel with _CounterCommands, _CounterConstructor {
  int counter = 0;

  CounterViewModel._();
  factory CounterViewModel(int a, {required bool b, String? c}) = _Counter;

  @Command(debugName: 'Test')
  int _add() {
    counter += 1;
    return counter;
  }

  @Command()
  Stream<int> _random() {
    final rand = Random();
    return Stream.value(rand.nextInt(100));
  }
}
