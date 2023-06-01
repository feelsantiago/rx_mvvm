import 'package:analyzer/dart/element/element.dart';
import 'package:rx_mvvm_builder/src/interfaces.dart';

class CommandParam implements CommandTypeDefinition {
  final String _type;
  final bool hasParam;

  const CommandParam(this._type, this.hasParam);
  const CommandParam.type(this._type) : hasParam = true;
  const CommandParam.empty()
      : _type = 'void',
        hasParam = false;

  factory CommandParam.from(MethodElement method) {
    final element = method.parameters.firstOrNull;

    if (element == null) {
      return const CommandParam.empty();
    }

    return CommandParam.type(
      element.type.getDisplayString(withNullability: true),
    );
  }

  @override
  String definition() {
    return hasParam ? '' : 'NoParam';
  }

  @override
  String type() {
    return _type;
  }
}
