import 'package:oxidized/oxidized.dart';

abstract interface class Disposable {
  String dispose();
}

abstract interface class MvvmBuilder {
  String get name;
  String write();
}

abstract interface class MvvmMixin extends MvvmBuilder implements Disposable {
  String initialization();
}

abstract interface class CommandTypeDefinition {
  String type();
  String definition();
}

abstract interface class ElementBuilder {
  String initialization();
  String definition();
}

abstract interface class ConstructorBuilder extends ElementBuilder {
  String params();
}

abstract interface class CommandBuilder extends ElementBuilder
    implements Disposable {
  String action();
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
  Result<bool, Exception> validate();
  Option<T> value();
}

abstract interface class PropertyBind {
  String binds();
}

abstract interface class PropertyBindEvent extends PropertyBind
    implements Disposable {}
