import 'package:hybrid_logger/hybrid_logger.dart';

/// ConsoleUtil abstract class
/// This class contains the utility methods for the console.
class ConsoleUtilImpl implements ConsoleUtil {
  /// Constructor that will create a new instance of the [ConsoleUtilImpl].
  const ConsoleUtilImpl();

  /// Method that will generate a String line with the given length and symbol.
  String getline(
    int length, {
    String lineSymbol = '',
  }) {
    final line = lineSymbol * length;
    return '┌$line';
  }

  /// Method that will generate a String line with the given length and symbol.
  /// Unlike getLine, initial symbol is reversed
  String getBottomLine(
    int length, {
    String lineSymbol = '',
  }) {
    final line = lineSymbol * length;
    return '└$line';
  }
}
