import 'package:hybrid_logger/hybrid_logger.dart';

/// Class that will filter the log entity based on the log type.
class LoggerFilterImpl implements LoggerFilter {
  /// The log level that will be used to filter the log entity.
  final LogTypeEntity _logLevel;

  /// Constructor that will create a new instance of the [LoggerFilterImpl].
  const LoggerFilterImpl({required LogTypeEntity logLevel}) : _logLevel = logLevel;

  /// List of log types in order of priority
  final List<LogTypeEntity> _logTypePriorityList = const [
    LogTypeEntity.httpResponse,
    LogTypeEntity.httpRequest,
    LogTypeEntity.httpError,
    LogTypeEntity.stacktrace,
    LogTypeEntity.success,
    LogTypeEntity.critical,
    LogTypeEntity.error,
    LogTypeEntity.warning,
    LogTypeEntity.info,
    LogTypeEntity.debug,
  ];

  @override
  bool shouldLog(LogTypeEntity level) {
    final currLogLevelIndex = _logTypePriorityList.indexOf(_logLevel);
    final msgLogLevelIndex = _logTypePriorityList.indexOf(level);
    return currLogLevelIndex >= msgLogLevelIndex;
  }
}
