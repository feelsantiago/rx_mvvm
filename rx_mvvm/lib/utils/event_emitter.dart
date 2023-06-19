import 'dart:async';

class EventEmitter<T> {
  final StreamController<T> _controller;

  EventEmitter() : _controller = StreamController.broadcast();

  void emit(T value) {
    _controller.sink.add(value);
  }

  Future<void> close() async {
    await _controller.close();
  }
}
