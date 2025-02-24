import 'package:hybrid_logger/hybrid_logger.dart';

/// Class that will format the log entity to a String with colors.
class ColorStyleLogger implements StyleSource {
  /// Constructor that will create a new instance of the [ColorStyleLogger].
  const ColorStyleLogger();
  @override
  String formater(LogEntity details, HybridSettings settings) {
    final underline = ConsoleUtil.getline(
      settings.maxLineWidth,
      lineSymbol: settings.lineSymbol,
    );
    final message = details.message?.toString() ?? '';
    final formattedLines = message.split('\n').map(details.color.write).toList()..add(details.color.write(underline));
    return formattedLines.join('\n');
  }
}
