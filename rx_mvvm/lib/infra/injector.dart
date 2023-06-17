import 'package:get_it/get_it.dart';

class Injector {
  final GetIt getIt;

  static Injector? _instance;

  Injector._(this.getIt);

  factory Injector() {
    if (Injector._instance case null) {
      throw Exception('Injector container was not initialized');
    }

    return Injector._instance!;
  }

  static init(GetIt getIt) {
    Injector._instance = Injector._(getIt);
  }

  T get<T>() {
    return getIt<T>();
  }
}
