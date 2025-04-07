/// Level of logs to segmentation фтв control logging output
enum LogTypeEntity {
  /// Error log level
  error,

  /// Critical log level
  critical,

  /// Information log level
  info,

  /// Debug log level
  debug,

  /// Warning log level
  warning,

  /// Success log level
  stacktrace,

  /// Success log level
  success,

  /// HTTP request log level
  httpResponse,

  /// HTTP response log level
  httpRequest,

  /// HTTP error log level
  httpError
}

/// List of log types in order of priority
final logTypePriorityList = [
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
