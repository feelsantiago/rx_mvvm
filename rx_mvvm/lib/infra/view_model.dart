import 'package:flutter/foundation.dart';
import 'package:rx_mvvm/utils/listener_sink.dart';

mixin ViewModelBase {
  final ListenerSink listeners = ListenerSink();

  void onInit() {}
  void onUpdate() {}

  @mustCallSuper
  Future<void> onDispose() async {
    await listeners.cancel();
  }

  void binds(dynamic widget);
}
