import 'package:hybrid_logger/hybrid_logger.dart';

final _defaultColors = {
  LogTypeEntity.critical: AnsiPen()..xterm(198),
  LogTypeEntity.error: AnsiPen()..red(),
  LogTypeEntity.warning: AnsiPen()..yellow(),
  LogTypeEntity.info: AnsiPen()..blue(),
  LogTypeEntity.debug: AnsiPen()..gray(),
  LogTypeEntity.success: AnsiPen()..xterm(49),
  LogTypeEntity.stacktrace: AnsiPen()..xterm(214),
  LogTypeEntity.httpRequest: AnsiPen()..xterm(012),
  LogTypeEntity.httpResponse: AnsiPen()..xterm(49),
  LogTypeEntity.httpError: AnsiPen()..red(),
};

/// Class that holds the settings data of the logger.
class HybridSettings {
  /// Default constructor for the settings.
  HybridSettings({
    Map<LogTypeEntity, AnsiPen>? colors,
    this.type = LogTypeEntity.info,
    this.lineSymbol = '─',
    this.maxLineWidth = 60,
    this.showLines = true,
    this.showHeaders = true,
    this.forceLogs = false,
    this.maxLogLength,
  }) {
    if (colors != null) {
      _defaultColors.addAll(colors);
    }
    this.colors.addAll(_defaultColors);
  }

  /// Color definitions for each log type. If not defined, it will use the default colors.
  final Map<LogTypeEntity, AnsiPen> colors = _defaultColors;

  /// Enum [LogTypeEntity] that defines the log type.
  final LogTypeEntity type;

  /// Symbol used to draw lines in the logs.
  final String lineSymbol;

  /// Maximum line width for the logs.
  final int maxLineWidth;

  /// Flag to show lines in the logs.
  final bool showLines;

  /// Flag to show headers in the logs.
  final bool showHeaders;

  /// Flag to force logs to be printed on release mode.
  final bool forceLogs;

  /// Max number of characters to show in the log. If null, there is no limit.
  final int? maxLogLength;

  /// Method to copy the settings with new values.
  HybridSettings copyWith({
    Map<LogTypeEntity, AnsiPen>? colors,
    LogTypeEntity? type,
    String? lineSymbol,
    int? maxLineWidth,
    bool? showLines,
    bool? showHeaders,
    bool? forceLogs,
  }) {
    return HybridSettings(
      colors: colors ?? this.colors,
      type: type ?? this.type,
      lineSymbol: lineSymbol ?? this.lineSymbol,
      maxLineWidth: maxLineWidth ?? this.maxLineWidth,
      showLines: showLines ?? this.showLines,
      showHeaders: showHeaders ?? this.showHeaders,
      forceLogs: forceLogs ?? this.forceLogs,
    );
  }
}
