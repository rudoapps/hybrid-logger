/// ConsoleUtil abstract class
/// This class contains the utility methods for the console.
abstract interface class ConsoleUtil {
  /// Method that will generate a String line with the given length and symbol.
  String getline(
    int length, {
    String lineSymbol = '',
  });

  /// Method that will generate a String line with the given length and symbol.
  /// Unlike getLine, initial symbol is reversed
  String getBottomLine(
    int length, {
    String lineSymbol = '',
  });
}
