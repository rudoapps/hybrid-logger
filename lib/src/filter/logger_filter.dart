import 'package:hybrid_logger/hybrid_logger.dart';

/// Abstract class that defines the structure of the logger filter.
abstract class LoggerFilter {
  /// Method that will check if the log should be logged based on the [LogTypeEntity] level.
  bool shouldLog(LogTypeEntity level);
}
