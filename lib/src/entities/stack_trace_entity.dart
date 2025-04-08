/// Entity class for stacktrace
class StackTraceEntity {
  /// File name of the stacktrace
  final String fileName;

  /// Function name of the stacktrace
  final String functionName;

  /// Caller function name of the stacktrace
  final String? callerFunctionName;

  /// Line number of the stacktrace
  final int? lineNumber;

  /// Column number of the stacktrace
  final int? columnNumber;

  /// Constructor for stacktrace entity
  const StackTraceEntity({
    required this.fileName,
    required this.functionName,
    this.callerFunctionName,
    this.lineNumber,
    this.columnNumber,
  });
}
