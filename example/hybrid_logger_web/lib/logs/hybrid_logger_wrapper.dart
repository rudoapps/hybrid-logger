import 'package:hybrid_logger/hybrid_logger.dart';

class HybridLoggerWrapper {
  static final HybridLoggerWrapper _instance = HybridLoggerWrapper._internal();
  final _hybridLogger = HybridLogger(
    settings: HybridSettings(type: LogTypeEntity.debug, maxLineWidth: 50, limitHeaderLength: false, forceLogs: false),
  );

  HybridLogger get logger => _hybridLogger;

  factory HybridLoggerWrapper() {
    return _instance;
  }
  HybridLoggerWrapper._internal();
}
