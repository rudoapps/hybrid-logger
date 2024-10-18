import 'package:hybrid_logger/hybrid_logger.dart';

abstract class StyleSource {
  String formater(LogEntity details, HybridSettings settings);
}
