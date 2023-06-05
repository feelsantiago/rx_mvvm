import 'package:oxidized/oxidized.dart';

abstract interface class MvvmBuilder {
  String get name;
  String write();
}

abstract interface class MvvmMixin extends MvvmBuilder {
  String initialization();
  String dispose();
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
  String options();
  bool exist();
}

abstract interface class CommandActionBuilder {
  String generate();
}

abstract interface class BuilderValidator<T extends Object> {
  Result<bool, Error> validate();
  Option<T> value();
}
