import 'package:hybrid_logger/hybrid_logger.dart';

/// Class that will filter the log entity based on the log type.
class LogTypeFilter implements LoggerFilter {
  /// Constructor that will create a new instance of the [LogTypeFilter].
  const LogTypeFilter(this.logLevel);

  /// The log level that will be used to filter the log entity.
  final LogTypeEntity logLevel;

  @override
  bool shouldLog(LogTypeEntity level) {
    final currLogLevelIndex = logTypePriorityList.indexOf(logLevel);
    final msgLogLevelIndex = logTypePriorityList.indexOf(level);
    return currLogLevelIndex >= msgLogLevelIndex;
  }
}
