/// HybridHttpRequest log the HTTP request in the console.
class HybridHttpRequest {
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
}
