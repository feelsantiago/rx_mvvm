import 'package:injectable/injectable.dart';
import 'package:rx_mvvm/rx_mvvm.dart';

part 'counter_view_model.g.dart';

@singleton
class Service {}

@ViewModel()
class CounterViewModel extends _ViewModelBase {
  int counter = 0;

  @Input()
  late int myVariable;

  @Output()
  final EventEmitter<String> output = EventEmitter();

  CounterViewModel._();
  factory CounterViewModel(Service service) = _Counter;

  @Command()
  int _add() {
    counter += 1;
    return counter;
  }
}
