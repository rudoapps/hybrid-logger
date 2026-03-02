import 'package:hybrid_logger/hybrid_logger.dart';

class CustomLoggerFilter implements LoggerFilter {
  const CustomLoggerFilter(this.logLevel);

  final LogTypeEntity logLevel;

  @override
  bool shouldLog(LogTypeEntity level) {
    return true;
  }
}
