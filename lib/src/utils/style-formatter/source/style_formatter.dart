import 'package:hybrid_logger/hybrid_logger.dart';

/// Abstract class that defines the structure of the style source.
abstract interface class StyleFormatter {
  /// Method that will format the log entity to a String.
  String format({required LogEntity details, required HybridSettings settings});
}
