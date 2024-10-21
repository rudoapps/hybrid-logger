import 'package:hybrid_logger/hybrid_logger.dart';

class LogTypeFilter implements LoggerFilter {
  const LogTypeFilter(this.logLevel);

  final LogTypeEntity logLevel;

  @override
  bool shouldLog(LogTypeEntity level) {
    final currLogLevelIndex = logTypePriorityList.indexOf(logLevel);
    final msgLogLevelIndex = logTypePriorityList.indexOf(level);
    return currLogLevelIndex >= msgLogLevelIndex;
  }
}
