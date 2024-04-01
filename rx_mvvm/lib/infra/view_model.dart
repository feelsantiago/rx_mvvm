import 'package:rx_mvvm/utils/listener_sink.dart';

mixin ViewModelBase {
  final ListenerSink listeners = ListenerSink();

  void onInit() {}
  void onUpdate() {}
  void onDispose() {}

  Future<void> close() async {
    await listeners.cancel();
  }

  void binds(dynamic widget) {}
}
