import 'package:hybrid_logger/hybrid_logger.dart';
import 'package:hybrid_logger/src/entities/stack_trace_entity.dart';

/// Class that will format the log entity to a String on the console.
class LineStyleLogger implements StyleSource {
  /// Constructor that will create a new instance of the [LineStyleLogger].
  const LineStyleLogger();

  @override
  String formater(LogEntity details, HybridSettings settings) {
    final header = _formatHeader(details.header, settings);
    final message = _formatMessage(details.message, settings);
    final logTypeHandlers = _getLogTypeHandlers(details, settings);
    final formattedLog = _formatLogLines(
      header,
      message,
      settings,
      logTypeHandlers,
    );

    return _applyColorAndJoin(formattedLog, details.color.write);
  }

  String _formatHeader(String? header, HybridSettings settings) {
    if (header == null) {
      return '';
    }

    String? trimmedHeader;

    if (header.length > settings.maxLineWidth) {
      trimmedHeader = settings.limitHeaderLength ? '${header.substring(0, settings.maxLineWidth - 4)}...' : header;
    }

    return '[${trimmedHeader ?? header}]';
  }

  String _formatMessage(dynamic message, HybridSettings settings) {
    if (settings.maxLogLength == null) return message.toString();

    final trimmedMessage = message.toString().length > settings.maxLogLength!
        ? '${message.toString().substring(0, settings.maxLogLength)}\n...'
        : message.toString();
    return trimmedMessage;
  }

  Map<String, String> _getLogTypeHandlers(LogEntity details, HybridSettings settings) {
    return {
      'stackTrace': details.type == LogTypeEntity.stacktrace && details.stack != null
          ? _formatStackTrace(details.stack!, settings)
          : '',
      'httpError': details.type == LogTypeEntity.httpError && details.httpError != null
          ? _formatHttpError(details.httpError!, settings)
          : '',
      'httpResponse': details.type == LogTypeEntity.httpResponse && details.httpResponse != null
          ? _formatHttpResponse(details.httpResponse!, settings)
          : '',
      'httpRequest': details.type == LogTypeEntity.httpRequest && details.httpRequest != null
          ? _formatHttpRequest(details.httpRequest!, settings)
          : '',
    };
  }

  List<String> _formatLogLines(
    String header,
    String message,
    HybridSettings settings,
    Map<String, String> logTypeHandlers,
  ) {
    final messageLines = _indentLines(message.split('\n'));
    final logLines = _selectLogLines(logTypeHandlers);

    final headerLine = ConsoleUtil.getline(
      settings.maxLineWidth,
      lineSymbol: settings.lineSymbol,
    );
    final footerLine = ConsoleUtil.getBottonLine(
      settings.maxLineWidth,
      lineSymbol: settings.lineSymbol,
    );

    final formattedLines = [
      if (settings.showHeaders && header.isNotEmpty) header,
      if (settings.showLines) headerLine,
      ...messageLines,
      ...logLines,
      if (settings.showLines) footerLine,
    ];

    return formattedLines.where((line) => line.isNotEmpty).toList();
  }

  List<String> _selectLogLines(Map<String, String> logTypeHandlers) {
    return logTypeHandlers.values.expand((log) => _indentLines(log.split('\n'))).toList();
  }

  List<String> _indentLines(List<String> lines) {
    return lines.map((line) => line.isNotEmpty ? '  $line' : line).toList();
  }

  String _applyColorAndJoin(
    List<String> lines,
    String Function(String) colorWriter,
  ) {
    const String reset = '\x1B[0m';
    const String gray = '\x1B[38;5;247m';
    return lines.map((line) {
      final String prefixedLine = '$gray[HL-LOG]$reset $line';
      final String coloredLine = prefixedLine.replaceFirst(line, colorWriter(line));
      return coloredLine;
    }).join('\n');
  }

  String _formatStackTrace(StackTrace stack, HybridSettings settings) {
    final stackEntity = _parseTrace(stack);
    final stackString = [stackEntity.fileName, '${stackEntity.functionName}()'].join('\n');

    if (settings.maxLogLength == null) return stackString;

    final trimmedMessage = stackString.length > settings.maxLogLength!
        ? '${stackString.substring(0, settings.maxLogLength)}\n...'
        : stackString;
    return trimmedMessage;
  }

  String _formatHttpError(HybridHttpError error, HybridSettings settings) {
    final String errorString = " => PATH: ${error.path}\n"
        " => STATUS CODE: ${error.statusCode}";

    if (settings.maxLogLength == null) return errorString;

    final trimmedMessage = errorString.length > settings.maxLogLength!
        ? '${errorString.substring(0, settings.maxLogLength)}\n...'
        : errorString;
    return trimmedMessage;
  }

  String _formatHttpResponse(HybridHttpResponse response, HybridSettings settings) {
    final String responseString = " => RESPONSE STATUS CODE: ${response.statusCode}\n"
        " => RESPONSE STATUS MESSAGE: ${response.statusMessage} \n"
        " => RESPONSE DATA: ${response.data}\n"
        " => MS: ${response.ms}";

    if (settings.maxLogLength == null) return responseString;

    final trimmedMessage = responseString.length > settings.maxLogLength!
        ? '${responseString.substring(0, settings.maxLogLength)}\n...'
        : responseString;
    return trimmedMessage;
  }

  String _formatHttpRequest(HybridHttpRequest request, HybridSettings settings) {
    final String requestString = " => BASE URL: ${request.baseUrl}\n"
        " => PATH: ${request.path}\n"
        " => DATA: ${request.data}\n"
        " => QUERY PARAMS: ${request.queryParameters}\n"
        " => HEADERS: ${request.headers}\n"
        " => RESPONSE TYPE: ${request.responseType}\n"
        " => METHOD: ${request.method}";

    if (settings.maxLogLength == null) return requestString;

    final trimmedMessage = requestString.length > settings.maxLogLength!
        ? '${requestString.substring(0, settings.maxLogLength)}\n...'
        : requestString;
    return trimmedMessage;
  }

  StackTraceEntity _parseTrace(StackTrace trace) {
    final frames = trace.toString().split('\n');
    final functionName = _getFunctionNameFromFrame(frames[0]);
    //final callerFunctionName = _getFunctionNameFromFrame(frames[1]);
    final traceString = frames[0];
    final fileName = _extractFileName(traceString);
    //final lineNumber = _extractLineNumber(traceString);
    //final columnNumber = _extractColumnNumber(traceString);

    return StackTraceEntity(fileName: fileName, functionName: functionName);
  }

  String _extractFileName(String traceString) {
    final fileNamePattern = RegExp(r'[A-Za-z_]+\.dart');
    return fileNamePattern.firstMatch(traceString)?.group(0) ?? '';
  }

  String _getFunctionNameFromFrame(String frame) {
    final currentTrace = frame;
    var indexOfWhiteSpace = currentTrace.indexOf(' ');
    var subStr = currentTrace.substring(indexOfWhiteSpace);
    final indexOfFunction = subStr.indexOf(RegExp('[A-Za-z0-9]'));
    subStr = subStr.substring(indexOfFunction);
    indexOfWhiteSpace = subStr.indexOf(' ');
    // ignore: join_return_with_assignment
    subStr = subStr.substring(0, indexOfWhiteSpace);
    return subStr;
  }
}
