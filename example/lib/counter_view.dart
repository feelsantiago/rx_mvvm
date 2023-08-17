import 'package:example/counter_view_model.dart';
import 'package:flutter/material.dart';
import 'package:rx_mvvm/rx_mvvm.dart';

class CounterView extends RxView<CounterViewModel> {
  final String title;

  CounterView({Key? key, required this.title}) : super(key: key);

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
        onPressed: viewModel.add,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
