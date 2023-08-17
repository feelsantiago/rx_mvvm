# RX MVVM

This package helps create MVVM applications using RX programming as communication tools between UI and ViewModel layer.

This package uses [RxCommands](https://pub.dev/packages/rx_command), you can check it's documentation for more information.

This package depends on [Injectable/Injectable Generator/Get It](https://pub.dev/packages/injectable) as dependency injector container. You need to configure them as well.

### Instalation

---

```yaml
dependencies:
  rx_mvvm:
  injectable:
  get_it:

dev_dependencies:
  rx_mvvm_builder:
  injectable_generator:
  build_runner:
```

### Setup

---

```dart
import 'package:rx_mvvm/rx_mvvm.dart';

void main() {
  // Injectable/Get It configuration
  configureDependencies();
  Injector.init(getIt);

  runApp(MyApp());
}
```

### ViewModel

To setup a _ViewModel_ you need to extend from _\_ViewModelBase_ and override default constructors.

```dart
import 'package:injectable/injectable.dart';
import 'package:rx_mvvm/rx_mvvm.dart';

// Define the part file
part 'counter_view_model.g.dart';

@singleton
class Service {}

@ViewModel()
class CounterViewModel extends _ViewModelBase {
  int counter = 0;

  @Input()
  late int title;

  @Output()
  final EventEmitter<String> output = EventEmitter();

  // Make default constructor private
  CounterViewModel._();
  // Override contructor with the generate one (Is the class name without ViewModel)
  factory CounterViewModel(Service service) = _Counter;

  // Life Cycles
  @override
  void OnInit() {}
  @override
  void onUpdate() {}
  @override
  Future<void> onDispose() async {
    // must call super
    super.onDispose();
  }

  // Commands must be private
  @Command()
  int _add() {
    counter += 1;
    return counter;
  }
}
```

`@Input({ String? property })` - Bind view property, if no property is passed defaults to variable name.
`@Output({ String? property })` - Bind view callbacks, if no property is passed defaults to variable name.
`@Command(...rx_command options)` - Create a command action, will be the public version of the method.

### View

```dart
import 'package:example/counter_view_model.dart';
import 'package:flutter/material.dart';
import 'package:rx_mvvm/rx_mvvm.dart';

class CounterView extends RxView<CounterViewModel> {
  // Binds to viewModel
  final String title;
  final String Function() output;

  CounterView({Key? key, required this.title, required this.output}) : super(key: key);

  // Life Cycles
  @override
  void onFocusLost() {}
  @override
  void onFocusGained() {}
  @override
  void onVisibilityLost() {}
  @override
  void onVisibilityGained() {}
  @override
  void onForegroundLost() {}
  @override
  void onForegroundGained() {}
  @override
  void didChangeDependencies() {}
  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder(
              // viewModel property is available
              stream: viewModel.onAdd.values,
              initialData: viewModel.counter,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // viewModel actions
        onPressed: viewModel.add,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

- `this.viewModel` - Is available in all classe and all life cycle methods.
- `this.viewModel.{commandName}` - each command have a public version to be called.
- `this.viewModel.on{commandName}` - each command has a property with all events
  - `values` - Stream of returned values
  - `results` - Stream of `CommandsResults`
  - `exceptions` - Stream of errors
  - `executing` - Stream of command current state
  - `canExecute` - Stream of command availability
  - `command` - Command object
