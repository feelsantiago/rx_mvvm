import 'dart:async';

class ListenerSink {
  final List<StreamSubscription> _sink = [];

  set sink(StreamSubscription listener) {
    _sink.add(listener);
  }

  void add(StreamSubscription listener) {
    _sink.add(listener);
  }

  void addAll(Iterable<StreamSubscription> listeners) {
    _sink.addAll(listeners);
  }

  Future<void> cancel() async {
    await Future.wait(_sink.map((listener) => listener.cancel()));
    _sink.clear();
  }
}
