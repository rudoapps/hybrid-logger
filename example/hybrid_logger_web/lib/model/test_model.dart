import 'package:hybrid_logger_web/logs/hybrid_logger_wrapper.dart';

class TestModel {
  void stackMethodTest() {
    HybridLoggerWrapper().logger.stackTrx(StackTrace.current, header: 'StackTrace from method');
  }
}
