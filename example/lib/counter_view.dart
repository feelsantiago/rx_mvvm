import 'package:example/counter_view_model.dart';
import 'package:flutter/material.dart';

class CounterView extends StatelessWidget {
  final String title;

  CounterView({Key? key, required this.title}) : super(key: key);

  final CounterViewModel viewModel = CounterViewModel();

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
            Text(
              '${viewModel.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
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
