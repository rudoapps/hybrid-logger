import 'package:hybrid_logger/hybrid_logger.dart';

abstract class LoggerFilter {
  bool shouldLog(LogTypeEntity level);
}
