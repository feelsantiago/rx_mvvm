abstract interface class MvvmBuilder {
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
  String dispose();
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
