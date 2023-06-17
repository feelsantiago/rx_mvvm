class Command {
  final bool emitInitialValue;
  final bool emitLastValue;
  final String? debugName;
  final String? restriction;

  const Command({
    this.emitInitialValue = false,
    this.emitLastValue = false,
    this.debugName,
    this.restriction,
  });
}
