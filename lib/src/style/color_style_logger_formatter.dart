import 'package:hybrid_logger/hybrid_logger.dart';

class ColorStyleLogger implements StyleSource {
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
