import 'dart:convert';
import 'dart:developer';
import 'package:hybrid_logger/hybrid_logger.dart';

void main() {
  final logger = HybridLogger(settings: HybridSettings(type: LogTypeEntity.debug, maxLogLength: 150));

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
  logger.error('error ',
      header:
          '''Consequat nisi officia qui occaecat officia. Quis do consequat irure eu elit excepteur amet. Enim enim deserunt elit quis tempor do ad eiusmod minim ipsum exercitation et.

Ex laboris sit exercitation minim Lorem non in ea aute eu exercitation. Aliquip ullamco proident labore sint cillum ullamco deserunt minim pariatur laborum non cupidatat reprehenderit. Incididunt reprehenderit consequat ex est duis cillum enim voluptate exercitation consectetur cupidatat excepteur tempor cillum. Id nulla sint aliqua ut.

Ut excepteur ipsum veniam minim dolor exercitation eiusmod officia ex exercitation dolore cillum cupidatat. Est tempor id occaecat do cupidatat aute tempor dolor id eiusmod amet id officia nulla. Labore fugiat consectetur quis officia et excepteur ut minim adipisicing et ad duis. Dolore et in labore voluptate ad enim in velit reprehenderit. Mollit eiusmod in enim id excepteur. Proident Lorem eu officia incididunt eu irure voluptate Lorem aute labore anim ad. Laboris fugiat magna aliqua commodo laboris ex officia nulla elit.

Aute dolore anim nulla ea pariatur nulla mollit et ipsum. Dolore labore laboris mollit veniam velit Lorem minim officia sit. Ullamco sint amet adipisicing minim magna laboris proident ex laboris. Cillum consequat pariatur adipisicing cupidatat laborum incididunt laboris laborum tempor reprehenderit elit commodo.

Id ea sint proident adipisicing laborum laborum. Do ut enim amet amet labore. Ipsum nostrud magna irure officia in sunt magna laborum proident nisi. Laborum incididunt reprehenderit voluptate nulla. Laborum sint sunt proident Lorem eiusmod dolor velit incididunt. Cupidatat incididunt do do exercitation ipsum ullamco laboris cillum.

Ea esse proident incididunt quis nisi quis mollit eiusmod proident nulla ut id amet occaecat. Excepteur in in dolor laborum pariatur dolore cupidatat aute labore id. Ea culpa tempor voluptate excepteur. Pariatur esse laborum eu ipsum.

Irure anim nostrud aute aute commodo. Eu nisi amet id nostrud magna nisi magna excepteur qui adipisicing occaecat anim. Qui in adipisicing deserunt mollit consectetur.

Est nostrud mollit incididunt dolore. Officia et ipsum anim sit esse. Deserunt cupidatat labore do et nostrud consequat ex ad enim est nulla ea et culpa. Id excepteur ipsum non tempor deserunt ea consequat cillum sint ex laboris dolore duis commodo. Ad eiusmod non incididunt ex eiusmod adipisicing.''');
  logger.critical('Critical');
  logger.httpError(const HybridHttpError(path: 'Test/text/v2', statusCode: '500'));
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
