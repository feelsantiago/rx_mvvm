import 'package:example/config.dart';
import 'package:flutter/material.dart';
import 'package:rx_mvvm/infra/injector.dart';

import 'counter_view.dart';

void main() {
  configureDependencies();
  Injector.init(getIt);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CounterView(title: 'Flutter Demo Home Page'),
    );
  }
}
