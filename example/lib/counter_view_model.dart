import 'package:injectable/injectable.dart';
import 'package:rx_mvvm/rx_mvvm.dart';

part 'counter_view_model.g.dart';

@singleton
class Service {}

@ViewModel()
class CounterViewModel extends _ViewModelBase {
  int counter = 0;

  @Input()
  int get myVariable;

  CounterViewModel._();
  factory CounterViewModel(Service service) = _Counter;

  @Command(debugName: 'Test')
  int _add() {
    counter += 1;
    return counter;
  }

  int _test() {
    return 0;
  }
}
