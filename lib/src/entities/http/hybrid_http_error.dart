/// HybridHttpError is the entity that is used to log the HTTP error in the console.
class HybridHttpError {
  /// The path of the error.
  final String path;

  /// The status message of the error.
  final dynamic statusMessage;

  /// The status code of the error.
  final String statusCode;

  /// Constructor that will create a new instance of the [HybridHttpError].
  const HybridHttpError({
    required this.path,
    this.statusMessage,
    required this.statusCode,
  });
}
