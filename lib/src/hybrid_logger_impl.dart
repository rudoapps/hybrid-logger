import 'package:hybrid_logger/hybrid_logger.dart';
import 'package:hybrid_logger/src/utils/filter/logger_filter_impl.dart';
import 'package:hybrid_logger/src/source/hybrid_logger.dart';
import 'package:hybrid_logger/src/utils/style-formatter/line_style_formatter.dart';
import 'dart:developer' as dev;

/// Class that holds the logger instance which methods can log on the console.
class HybridLoggerImpl implements HybridLogger {
  /// [HybridSettings] - Settings for the logger.
  final HybridSettings settings;

  /// Formatter for the logger. Defined by the [LineStyleFormatter] which is an implementation of [StyleFormatter].
  final StyleFormatter formatter;

  final LoggerFilter _filter;

  /// Default constructor for the logger.
  /// * [settings] - The [HybridSettings] for the logger, if null it will use the default settings.
  /// * [formatter] - The [LineStyleFormatter] for the logger, if null it will use the default formatter.
  /// * [filter] - The [LoggerFilter] for the logger, if null it will use the default filter.
  HybridLoggerImpl({
    HybridSettings? settings,
    this.formatter = const LineStyleFormatter(),
    LoggerFilter? filter,
  })  : settings = settings ?? HybridSettings(),
        _filter = filter ?? LoggerFilterImpl(logLevel: (settings ?? HybridSettings()).type) {
    ansiColorDisabled = false;
  }

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
    final selectedColor =
        color ?? settings.colors[selectedType] ?? (AnsiPen()..gray());
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

      final formattedMsg = formatter.format(details: logEntity, settings: settings);
      if (forceLogs) {
        _outputLogRelease(formattedMsg);
      } else {
        _outputLog(formattedMsg);
      }
    }
  }

  /// Method that will log the message on the console with the [LogTypeEntity.critical] level.
  void critical(dynamic msg, {String? header}) =>
      log(msg, header: header, level: LogTypeEntity.critical);

  /// Method that will log the message on the console with the [LogTypeEntity.error] level.
  /// Unlike other methods, this method will log the stack trace if it is provided.
  void error(dynamic msg, {String? header, StackTrace? stack}) => log(
        stack != null ? "" : msg,
        header: stack != null
            ? '${header != null ? '$header | ' : ''}$msg'
            : header,
        stackTrx: stack,
        level: LogTypeEntity.stacktrace,
        color: AnsiPen()..red(),
      );

  /// Method that will log the message on the console with the [LogTypeEntity.warning] level.
  void warning(dynamic msg, {String? header}) =>
      log(msg, header: header, level: LogTypeEntity.warning);

  /// Method that will log the message on the console with the [LogTypeEntity.debug] level.
  void debug(dynamic msg, {String? header}) => log(msg, header: header);

  /// Method that will log the message on the console with the [LogTypeEntity.info] level.
  void info(dynamic msg, {String? header}) =>
      log(msg, header: header, level: LogTypeEntity.info);

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
        header: 'HTTP Interceptor Request',
        level: LogTypeEntity.httpRequest,
        httpRequest: request,
      );

  /// Method that will log the [HybridHttpResponse] on the console with the [LogTypeEntity.httpResponse] level.
  void httpResponse(HybridHttpResponse response) => log(
        "",
        header: 'HTTP Interceptor Response',
        level: LogTypeEntity.httpResponse,
        httpResponse: response,
      );

  /// Method that will log the [HybridHttpError] on the console with the [LogTypeEntity.httpError] level.
  void httpError(HybridHttpError httpError) => log(
        "",
        header: 'HTTP Interceptor Error',
        level: LogTypeEntity.httpError,
        httpError: httpError,
      );

  /// Copy method that will return a new instance of the logger with the given parameters.
  HybridLogger copyWith({
    HybridSettings? settings,
    StyleFormatter? formatter,
    LoggerFilter? filter,
    Function(String message)? output,
    Function(String message)? outputRelease,
  }) {
    return HybridLoggerImpl(
      settings: settings ?? this.settings,
      formatter: formatter ?? this.formatter,
      filter: filter ?? _filter,
    );
  }

  // Method that will log the message on the console.
  void _outputLog(String message) {
    final StringBuffer buffer = StringBuffer();
    message.split('\n').forEach(buffer.writeln);
    dev.log(buffer.toString());
  }

  // Method that will log the message on the console on release mode.
  void _outputLogRelease(String message) => message.split('\n').forEach(print);
}
