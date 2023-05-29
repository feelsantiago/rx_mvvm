class ViewModel {
  const ViewModel();
}

class Command {
  final bool emitInitialResult;
  final bool emitLastValue;
  final String? debugName;
  final String? restriction;

  const Command({
    this.emitInitialResult = false,
    this.emitLastValue = false,
    this.debugName,
    this.restriction,
  });
}
