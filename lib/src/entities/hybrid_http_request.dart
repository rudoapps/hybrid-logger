/// HybridHttpRequest log the HTTP request in the console.
class HybridHttpRequest {
  /// Constructor that will create a new instance of the [HybridHttpRequest].
  const HybridHttpRequest({
    required this.path,
    this.baseUrl,
    this.data,
    this.queryParameters,
    this.headers,
    this.responseType,
    required this.method,
  });

  /// The path of the request.
  final String path;

  /// The base URL of the request.
  final dynamic baseUrl;

  /// The data of the request.
  final dynamic data;

  /// The query parameters of the request.
  final dynamic queryParameters;

  /// The headers of the request.
  final dynamic headers;

  /// The response type of the request.
  final dynamic responseType;

  /// The method of the request.
  final String method;
}

/// HybridHttpResponse is the entity that is used to log the HTTP response in the console.
class HybridHttpResponse {
  /// Constructor that will create a new instance of the [HybridHttpResponse].
  const HybridHttpResponse({
    required this.statusCode,
    this.statusMessage,
    this.data,
    this.ms,
  });

  /// The status code of the response.
  final String statusCode;

  /// The status message of the response.
  final dynamic statusMessage;

  /// The data of the response.
  final dynamic data;

  /// The time taken to get the response.
  final String? ms;
}

/// HybridHttpError is the entity that is used to log the HTTP error in the console.
class HybridHttpError {
  /// Constructor that will create a new instance of the [HybridHttpError].
  const HybridHttpError({
    required this.path,
    this.statusMessage,
    required this.statusCode,
  });

  /// The path of the error.
  final String path;

  /// The status message of the error.
  final dynamic statusMessage;

  /// The status code of the error.
  final String statusCode;
}
