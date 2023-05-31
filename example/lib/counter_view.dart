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
            StreamBuilder(
              stream: viewModel.onRandom.values,
              initialData: 0,
              builder: (context, snapshot) {
                return Text('Random number from stream: ${snapshot.data}');
              },
            ),
            ElevatedButton(
              onPressed: viewModel.random,
              child: const Text('Random'),
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
