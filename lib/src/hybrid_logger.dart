import 'package:hybrid_logger/hybrid_logger.dart';
import 'package:hybrid_logger/src/utils/hybrid_logger_debug_io.dart' as log_output;
import 'package:hybrid_logger/src/utils/hybrid_logger_release_io.dart' as log_output_release;

class HybridLogger {
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

  late final HybridSettings settings;

  final LineStyleLogger formatter;

  late final void Function(String message) _output;

  late final void Function(String message) _outputRelease;
  late final LoggerFilter _filter;

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

  void critical(dynamic msg, {String? header}) => log(msg, header: header, level: LogTypeEntity.critical);

  void error(dynamic msg, {String? header}) => log(msg, header: header, level: LogTypeEntity.error);

  void warning(dynamic msg, {String? header}) => log(msg, header: header, level: LogTypeEntity.warning);

  void debug(dynamic msg, {String? header}) => log(msg, header: header);

  void info(dynamic msg, {String? header}) => log(msg, header: header, level: LogTypeEntity.info);

  void success(dynamic msg, {String? header}) => log(
        msg,
        header: header,
        level: LogTypeEntity.success,
      );

  void stackTrx(StackTrace stack, {String? header}) => log(
        "",
        stackTrx: stack,
        header: header,
        level: LogTypeEntity.stacktrace,
      );

  void httpRequest(HybridHttpRequest request) => log(
        "",
        header: 'Dio Interceptor Request',
        level: LogTypeEntity.httpRequest,
        httpRequest: request,
      );

  void httpResponse(HybridHttpResponse response) => log(
        "",
        header: 'Dio Interceptor Response',
        level: LogTypeEntity.httpResponse,
        httpResponse: response,
      );

  void httpError(HybridHttpError httpError) => log(
        "",
        header: 'Dio Interceptor Error',
        level: LogTypeEntity.httpError,
        httpError: httpError,
      );

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
