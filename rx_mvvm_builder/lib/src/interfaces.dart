abstract interface class MvvBuilder {
  String write();
}

abstract interface class CommandTypeDefinition {
  String type();
  String definition();
}

abstract interface class CommandBuilder {
  String definition();
  String action();
  String initialization();
  bool defined();
}

abstract interface class CommandAnnotationDefinition {
  String emitInitialValue();
  String emitLastValue();
  String debugName();
  String restriction();
  String parameters();
  bool exist();
}
