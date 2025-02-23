import 'package:hybrid_logger/hybrid_logger.dart';

class LogEntity {
  const LogEntity({
    this.header,
    required this.message,
    required this.type,
    required this.color,
    this.stack,
    this.httpRequest,
    this.httpResponse,
    this.httpError,
  });

  final String? header;

  final dynamic message;

  final LogTypeEntity type;

  final AnsiPen color;
  final StackTrace? stack;
  final HybridHttpError? httpError;
  final HybridHttpRequest? httpRequest;
  final HybridHttpResponse? httpResponse;
}
