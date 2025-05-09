import 'dart:convert';
import 'dart:developer';
import 'package:hybrid_logger/hybrid_logger.dart';

void main() {
  final logger = HybridLogger(
      settings: HybridSettings(type: LogTypeEntity.debug, maxLogLength: 150));

  // Init Logger with max log length
  // final logger = HybridLogger(
  //   settings: HybridSettings(
  //     type: LogTypeEntity.debug,
  //     maxLogLength: 500,
  //   ),
  // );

  // Init Logger with custom filter
  // final logger2 = HybridLogger(
  //   settings: HybridSettings(),
  //   filter: const CustomLogTypeFilter(
  //     LogTypeEntity.httpError,
  //   ),
  // );

  logger.debug('debug', header: 'test 1');
  logger.info('info');
  logger.success('type');
  logger.warning('warning', header: 'test 2');
  logger.httpRequest(
    const HybridHttpRequest(
      path: "/holi",
      method: "GET",
      baseUrl: "https://meloinvento/api",
      data: {},
      queryParameters: {},
      headers: {},
    ),
  );
  logger.httpResponse(
    const HybridHttpResponse(
      statusCode: "500",
    ),
  );
  logger.error('error');
  logger.critical('Critical');
  logger.httpError(
      const HybridHttpError(path: 'Test/text/v2', statusCode: '500'));
  logger.log(
    'log with level info',
    header: 'test 6',
    level: LogTypeEntity.error,
  );

  final formatedData = convertStringFormat({
    "id": 1,
    "title": "iPhone 9",
    "description": "An apple mobile which is nothing like apple",
    "price": 549,
    "discountPercentage": 12.96,
    "rating": 4.69,
    "stock": 94,
    "brand": "Apple",
    "category": "smartphones",
    "thumbnail": "...",
    "images": ["...", "...", "..."],
  });
  logger.log(formatedData, level: LogTypeEntity.success);

  try {
    simulateError();
  } catch (exception, stacktrace) {
    logger.error(exception, stack: stacktrace);
    logger.error(exception, header: 'Custom header', stack: stacktrace);
    logger.error(exception, header: 'Custom header');
    logger.error(exception);
  }
  debugger();
}

String convertStringFormat(dynamic object) {
  const encoder = JsonEncoder.withIndent('  ');
  final formatedData = encoder.convert(object);
  return formatedData;
}

void simulateError() {
  throw Exception('Simulated exception');
}
