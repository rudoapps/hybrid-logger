/// HybridHttpResponse is the entity that is used to log the HTTP response in the console.
class HybridHttpResponse {
  /// The status code of the response.
  final String statusCode;

  /// The status message of the response.
  final dynamic statusMessage;

  /// The data of the response.
  final dynamic data;

  /// The time taken to get the response.
  final String? ms;

  /// Constructor that will create a new instance of the [HybridHttpResponse].
  const HybridHttpResponse({
    required this.statusCode,
    this.statusMessage,
    this.data,
    this.ms,
  });
}
