import 'package:hybrid_logger/hybrid_logger.dart';
import 'package:hybrid_logger/src/utils/hybrid_logger_debug_io.dart' as log_output;
import 'package:hybrid_logger/src/utils/hybrid_logger_release_io.dart' as log_output_release;

/// Class that holds the logger instance which methods can log on the console.
class HybridLogger {
  /// Default constructor for the logger.
  HybridLogger({
    HybridSettings? settings,
    this.formatter = const LineStyleLogger(),
    LoggerFilter? filter,
  }) {
    this.settings = settings ?? HybridSettings();
    _output = log_output.outputLog;
    _outputRelease = log_output_release.outputLogRelease;
    _filter = filter ?? LogTypeFilter(this.settings.type);
    ansiColorDisabled = false;
  }

  /// [HybridSettings] - Settings for the logger.
  late final HybridSettings settings;

  /// Formatter for the logger. Defined by the [LineStyleLogger] which is an implementation of [StyleSource].
  final LineStyleLogger formatter;

  /// Private method that will log the message on the console.
  /// Currently
  late final void Function(String message) _output;

  ///private method that will log the message on the console on release mode.
  late final void Function(String message) _outputRelease;

  late final LoggerFilter _filter;

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
  }) {
    final selectedType = level ?? LogTypeEntity.debug;
    final selectedColor = color ?? settings.colors[selectedType] ?? (AnsiPen()..gray());
    final shouldLog = _filter.shouldLog(selectedType);
    final forceLogs = settings.forceLogs;

    if (shouldLog || forceLogs) {
      final logEntity = LogEntity(
        message: msg,
        header: header,
        type: selectedType,
        color: selectedColor,
        stack: stackTrx,
        httpError: httpError,
        httpResponse: httpResponse,
        httpRequest: httpRequest,
      );

      final formattedMsg = formatter.formater(logEntity, settings);
      if (forceLogs) {
        _outputRelease(formattedMsg);
      } else {
        _output(formattedMsg);
      }
    }
  }

  /// Method that will log the message on the console with the [LogTypeEntity.critical] level.
  void critical(dynamic msg, {String? header}) => log(msg, header: header, level: LogTypeEntity.critical);

  /// Method that will log the message on the console with the [LogTypeEntity.error] level.
  /// Unlike other methods, this method will log the stack trace if it is provided.
  void error(dynamic msg, {String? header, StackTrace? stack}) => log(
        stack != null ? "" : msg,
        header: stack != null ? '${header != null ? '$header | ' : ''}$msg' : header,
        stackTrx: stack,
        level: LogTypeEntity.stacktrace,
        color: AnsiPen()..red(),
      );

  /// Method that will log the message on the console with the [LogTypeEntity.warning] level.
  void warning(dynamic msg, {String? header}) => log(msg, header: header, level: LogTypeEntity.warning);

  /// Method that will log the message on the console with the [LogTypeEntity.debug] level.
  void debug(dynamic msg, {String? header}) => log(msg, header: header);

  /// Method that will log the message on the console with the [LogTypeEntity.info] level.
  void info(dynamic msg, {String? header}) => log(msg, header: header, level: LogTypeEntity.info);

  /// Method that will log the message on the console with the [LogTypeEntity.success] level.
  void success(dynamic msg, {String? header}) => log(
        msg,
        header: header,
        level: LogTypeEntity.success,
      );

  /// Method that will log the stack trace on the console with the [LogTypeEntity.stacktrace] level.
  void stackTrx(StackTrace stack, {String? header}) => log(
        "",
        stackTrx: stack,
        header: header,
        level: LogTypeEntity.stacktrace,
      );

  /// Method that will log the [HybridHttpRequest] on the console with the [LogTypeEntity.httpRequest] level.
  void httpRequest(HybridHttpRequest request) => log(
        "",
        header: 'Dio Interceptor Request',
        level: LogTypeEntity.httpRequest,
        httpRequest: request,
      );

  /// Method that will log the [HybridHttpResponse] on the console with the [LogTypeEntity.httpResponse] level.
  void httpResponse(HybridHttpResponse response) => log(
        "",
        header: 'Dio Interceptor Response',
        level: LogTypeEntity.httpResponse,
        httpResponse: response,
      );

  /// Method that will log the [HybridHttpError] on the console with the [LogTypeEntity.httpError] level.
  void httpError(HybridHttpError httpError) => log(
        "",
        header: 'Dio Interceptor Error',
        level: LogTypeEntity.httpError,
        httpError: httpError,
      );

  /// Copy method that will return a new instance of the logger with the given parameters.
  HybridLogger copyWith({
    HybridSettings? settings,
    LineStyleLogger? formatter,
    LoggerFilter? filter,
    Function(String message)? output,
    Function(String message)? outputRelease,
  }) {
    return HybridLogger(
      settings: settings ?? this.settings,
      formatter: formatter ?? this.formatter,
      filter: filter ?? _filter,
    );
  }
}
