import 'package:hybrid_logger/hybrid_logger.dart';

class LogTypeilterCustom implements LoggerFilter {
  const LogTypeilterCustom(this.logLevel);

  final LogTypeEntity logLevel;

  @override
  bool shouldLog(LogTypeEntity level) {
    return true;
  }
}
