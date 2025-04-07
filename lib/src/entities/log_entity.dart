import 'package:hybrid_logger/hybrid_logger.dart';

/// Class that represents the log entity.
class LogEntity {
  /// Constructor that will create a new instance of the [LogEntity].
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

  /// The header of the log entity.
  final String? header;

  /// The message of the log entity.
  final dynamic message;

  /// The type of the log entity.
  final LogTypeEntity type;

  /// The color of the log entity.
  final AnsiPen color;

  /// The stack trace of the log entity.
  final StackTrace? stack;

  /// The http error of the log entity.
  final HybridHttpError? httpError;

  /// The http request of the log entity.
  final HybridHttpRequest? httpRequest;

  /// The http response of the log entity.
  final HybridHttpResponse? httpResponse;
}
