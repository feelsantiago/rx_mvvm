import 'package:rx_mvvm_builder/src/interfaces.dart';

class FakeCommandAnnotation implements CommandAnnotationDefinition {
  final String fDebugName;
  final String fEmitInitialValue;
  final String fEmitLastValue;
  final String fParameter;
  final String fRestriction;
  final bool fExist;

  const FakeCommandAnnotation({
    this.fDebugName = '',
    this.fEmitInitialValue = '',
    this.fEmitLastValue = '',
    this.fParameter = '',
    this.fRestriction = '',
    this.fExist = false,
  });

  @override
  String debugName() {
    return fDebugName;
  }

  @override
  String emitInitialValue() {
    return fEmitInitialValue;
  }

  @override
  String emitLastValue() {
    return fEmitLastValue;
  }

  @override
  String parameters() {
    return fParameter;
  }

  @override
  String restriction() {
    return fRestriction;
  }

  @override
  bool exist() {
    return fExist;
  }
}
