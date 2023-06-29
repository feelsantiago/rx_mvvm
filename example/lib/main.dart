import 'package:beamer/beamer.dart';
import 'package:example/config.dart';
import 'package:example/counter_view.dart';
import 'package:example/router_outlet.dart';
import 'package:flutter/material.dart';
import 'package:rx_mvvm/infra/injector.dart';

class CounterLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => ['/counter'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('counter'),
        title: 'Counter',
        type: BeamPageType.material,
        child: CounterView(title: 'Counter'),
      ),
    ];
  }
}

class OtherLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => ['/other'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('other'),
        title: 'Other',
        type: BeamPageType.material,
        child: OtherPage(),
      ),
    ];
  }
}

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Other Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Other Page'),
            ElevatedButton(
              onPressed: () {
                RouterOutlet.of(context).beamer.currentContext!.beamBack();
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RouterOutlet(
        child: Builder(builder: (context) {
          return Beamer(
            key: RouterOutlet.of(context).beamer,
            routerDelegate: BeamerDelegate(
              locationBuilder: BeamerLocationBuilder(
                beamLocations: [
                  CounterLocation(),
                  OtherLocation(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

void main() {
  configureDependencies();
  Injector.init(getIt);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final delegate = BeamerDelegate(
    initialPath: '/counter',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (context, state, data) => const HomeScreen(),
      },
    ),
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routeInformationParser: BeamerParser(),
      routerDelegate: delegate,
    );
  }
}
