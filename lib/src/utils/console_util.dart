/// ConsoleUtil abstract class
/// This class contains the utility methods for the console.
abstract class ConsoleUtil {
  ConsoleUtil._();

  /// Method that will generate a String line with the given length and symbol.
  static String getline(
    int length, {
    String lineSymbol = '',
  }) {
    final line = lineSymbol * length;
    return '┌$line';
  }

  /// Method that will generate a String line with the given length and symbol.
  /// Unlike getLine, initial symbol is reversed
  static String getBottonLine(
    int length, {
    String lineSymbol = '',
  }) {
    final line = lineSymbol * length;
    return '└$line';
  }
}
