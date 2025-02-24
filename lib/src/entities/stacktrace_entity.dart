/// Entity class for stacktrace
class StacktraceEntity {
  /// Constructor for stacktrace entity
  const StacktraceEntity({
    required this.fileName,
    required this.functionName,
    this.callerFunctionName,
    this.lineNumber,
    this.columnNumber,
  });

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
}
