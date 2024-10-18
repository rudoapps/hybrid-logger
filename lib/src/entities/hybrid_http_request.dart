class HybridHttpRequest {
  const HybridHttpRequest({
    required this.path,
    this.baseUrl,
    this.data,
    this.queryParameters,
    this.headers,
    this.responseType,
    required this.method,
  });

  final String path;
  final dynamic baseUrl;
  final dynamic data;
  final dynamic queryParameters;
  final dynamic headers;
  final dynamic responseType;
  final String method;
}

class HybridHttpResponse {
  const HybridHttpResponse({
    required this.statusCode,
    this.statusMessage,
    this.data,
    this.ms,
  });

  final String statusCode;
  final dynamic statusMessage;
  final dynamic data;
  final String? ms;
}

class HybridHttpError {
  const HybridHttpError({
    required this.path,
    this.statusMessage,
    required this.statusCode,
  });

  final String path;
  final dynamic statusMessage;
  final String statusCode;
}
