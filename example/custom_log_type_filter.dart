import 'package:hybrid_logger/hybrid_logger.dart';

class CustomLogTypeFilter implements LoggerFilter {
  const CustomLogTypeFilter(this.logLevel);

  final LogTypeEntity logLevel;

  @override
  bool shouldLog(LogTypeEntity level) {
    return true;
  }
}
