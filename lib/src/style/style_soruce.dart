import 'package:hybrid_logger/hybrid_logger.dart';

/// Abstract class that defines the structure of the style source.
abstract class StyleSource {
  /// Method that will format the log entity to a String.
  String formater(LogEntity details, HybridSettings settings);
}
