import 'package:hybrid_logger/hybrid_logger.dart';
import 'package:hybrid_logger/src/utils/console-util/console_util_impl.dart';

/// Class that will format the log entity to a String with colors.
class ColorStyleFormatter implements StyleFormatter {
  final ConsoleUtil _consoleUtil;

  /// Constructor that will create a new instance of the [ColorStyleFormatter].
  ColorStyleFormatter({ConsoleUtil? consoleUtil}) : _consoleUtil = consoleUtil ?? ConsoleUtilImpl();

  /// Method that will format the log entity to a String.
  @override
  String format({required LogEntity details, required HybridSettings settings}) {
    final underline = _consoleUtil.getline(
      settings.maxLineWidth,
      lineSymbol: settings.lineSymbol,
    );
    final message = details.message?.toString() ?? '';
    final formattedLines = message.split('\n').map(details.color.write).toList()
      ..add(details.color.write(underline));
    return formattedLines.join('\n');
  }
}
