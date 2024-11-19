abstract class LogInterface {
  void handle(
    Object exception, [
    StackTrace? stackTrace,
    dynamic msg,
  ]);

  void log(dynamic message);

  void error(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  void info(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  void verbose(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  void warning(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  void critical(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  void debug(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);
}
