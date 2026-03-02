import 'package:hybrid_logger/hybrid_logger.dart';

/// Class that holds the logger instance which methods can log on the console.
abstract interface class HybridLogger {
  /// Base log function that will log the message on the console based on the given parameters and the [LogTypeEntity].
  /// * [msg] - The message that will be logged.
  /// * [header] - The header of the message.
  /// * [level] - The [LogTypeEntity] of the message. By default is [LogTypeEntity.debug].
  /// * [color] - The color of the message. Value will be defined by [level] and [HybridSettings] of the logger, if not defined is AnsiPen()..gray().
  /// * [stackTrx] - The stack trace of the message.
  /// * [httpRequest] - The [HybridHttpRequest] of the message.
  /// * [httpResponse] - The [HybridHttpResponse] of the message.
  /// * [httpError] - The [HybridHttpError] of the message.
  /// * [forceLogs] - If true, the message will be logged regardless of the [HybridSettings] of the logger in release.
  void log(
    dynamic msg, {
    String? header,
    LogTypeEntity? level,
    AnsiPen? color,
    StackTrace? stackTrx,
    HybridHttpRequest? httpRequest,
    HybridHttpResponse? httpResponse,
    HybridHttpError? httpError,
    bool? forceLogs,
  });

  /// Method that will log the message on the console with the [LogTypeEntity.critical] level.
  void critical(dynamic msg, {String? header});

  /// Method that will log the message on the console with the [LogTypeEntity.error] level.
  /// Unlike other methods, this method will log the stack trace if it is provided.
  void error(dynamic msg, {String? header, StackTrace? stack});

  /// Method that will log the message on the console with the [LogTypeEntity.warning] level.
  void warning(dynamic msg, {String? header});

  /// Method that will log the message on the console with the [LogTypeEntity.debug] level.
  void debug(dynamic msg, {String? header});

  /// Method that will log the message on the console with the [LogTypeEntity.info] level.
  void info(dynamic msg, {String? header});

  /// Method that will log the message on the console with the [LogTypeEntity.success] level.
  void success(dynamic msg, {String? header});

  /// Method that will log the stack trace on the console with the [LogTypeEntity.stacktrace] level.
  void stackTrx(StackTrace stack, {String? header});

  /// Method that will log the [HybridHttpRequest] on the console with the [LogTypeEntity.httpRequest] level.
  void httpRequest(HybridHttpRequest request);

  /// Method that will log the [HybridHttpResponse] on the console with the [LogTypeEntity.httpResponse] level.
  void httpResponse(HybridHttpResponse response);

  /// Method that will log the [HybridHttpError] on the console with the [LogTypeEntity.httpError] level.
  void httpError(HybridHttpError httpError);

  /// Copy method that will return a new instance of the logger with the given parameters.
  HybridLogger copyWith({
    HybridSettings? settings,
    StyleFormatter? formatter,
    LoggerFilter? filter,
    Function(String message)? output,
    Function(String message)? outputRelease,
  });
}
