import 'package:injectable/injectable.dart';
import 'package:rx_mvvm/rx_mvvm.dart';

part 'counter_view_model.g.dart';

@singleton
class Service {}

@ViewModel()
class CounterViewModel extends _ViewModelBase {
  int counter = 0;

  // listeners.sink = onChange.stream.listen((value) => widget.onChange(value));

  @Input()
  late int myVariable;

  EventEmitter<String> onChange = EventEmitter();

  CounterViewModel._();
  factory CounterViewModel(Service service) = _Counter;

  @Command(debugName: 'Test')
  int _add() {
    counter += 1;
    return counter;
  }
}
