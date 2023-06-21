typedef EventHandler<T> = void Function(T arg);

class EventEmitter<T> {
  late EventHandler<T> _handler;

  bool _closed = false;
  bool get isClosed => _closed;

  void subscribe(EventHandler<T> handler) {
    _handler = handler;
  }

  void operator +(EventHandler<T> handler) {
    _handler = handler;
  }

  void close() {
    _closed = true;
  }

  void emit(T value) {
    if (!_closed) {
      _handler(value);
    }
  }
}
