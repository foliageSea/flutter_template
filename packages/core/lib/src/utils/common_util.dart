StackTrace? handleStackTrace(StackTrace? stackTrace) {
  if (stackTrace != null) {
    final stackLines = stackTrace.toString().split('\n');
    if (stackLines.length > 8) {
      stackTrace = StackTrace.fromString(
          '${stackLines.take(8).join('\n')}\n... (${stackLines.length - 8} more)');
    }
  }
  return stackTrace;
}
