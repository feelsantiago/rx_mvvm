import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class RouterOutlet extends InheritedWidget {
  final GlobalKey<BeamerState> _key = GlobalKey();

  GlobalKey<BeamerState> get beamer => _key;

  RouterOutlet({super.key, required super.child});

  static RouterOutlet? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RouterOutlet>();
  }

  static RouterOutlet of(BuildContext context) {
    final router = maybeOf(context);
    assert(router != null, 'No Router Outlet found in context');

    return router!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
