![Hybrid Logger logo](https://raw.githubusercontent.com/rudoapps/hybrid-storage/main/flutter/images/hybrid-logger/hybrid-logger-logo.png)

# Hybrid Logger

A useful package that provides Log tools for development, it lets you choose between some logs designs or types, and have an easy track of http calls, stack trace, etc. 

## Functions provided by the package:

They can be divided in 3 main groups, such as **Common Log Functions**, **Stack Trace Log** and **Http Logs**

- ### Common Logs:

   - **critical(dynamic msg, {String? header})** 

   - **error(dynamic msg, {String? header})**

   - **warning(dynamic msg, {String? header})**

   - **debug(dynamic msg, {String? header})**

   - **info(dynamic msg, {String? header})**

   - **success(dynamic msg, {String? header})**

    These type of logs will show when they are called, header is optional meaning that it wont show one if its not setted and the style of each log relies on library defined color but it can be overwritten by configuring an Hybrid Settings Class.

- ### Stack Trace

   - **stackTrx(StackTrace stack, {String? header})**: To use it just call it on a function or method and give it the StackTrace.current, by doing that, always that the method is called there will be a log with its name and the file where its located.

- ### Http Logs

   - **httpRequest(HybridHttpRequest request)**: Method that needs an HybridHttpRequest, object that will have status code, data, query parameters, etc. Of the logged requests

   - **httpResponse(HybridHttpResponse response)**: Method that will need HybridHttpResponse to log response data 

   - **httpError(HybridHttpError httpError)**: Method that will need an HybridHttpError to log error data if http request is rejected or cannot be performed

## Using the package:

To use this package, simply import the package into your Pubspec.yaml, configure a HybridLogger instance and use its methods to perform the different types of logs

##### Create and configure an Hybrid Logger:

```dart
import 'package:hybrid_logger/hybrid_logger.dart';

final logger = HybridLogger(
    settings: HybridSettings(
        colors: {
            LogTypeEntity.debug: AnsiPen.green()
        },
        type: LogTypeEntity.info,
        lineSymbol: '-',
        maxLineWidth: 60,
        showLines: true,
        showHeaders: true,
        forceLogs: false,
    ),
);
```

##### Using the HybridLogger object, call the methods where you need to perform logs

```dart
void main() async {
    await apiCallMethod();
    stackTraceMethod();
    debugMethod();
}

// Http Logs will require parameters that you should get while performing an api call,
// if they are not setted, logger will show null on the field by default
Future<void> apiCallMethod() async {
    logger.httpRequest(
        const HybridHttpRequest(
            path: "/hello",
            method: "GET",
            baseUrl: "https://fakeapi/api",
            data: {},
            queryParameters: {},
            headers: {},
        ),
    );
    logger.httpResponse(
        const HybridHttpResponse(
            statusCode: "200",
            data: {"message": "Hello World!"}
        ),
    );
    logger.httpError(
        const HybridHttpError(
            path: 'Test/text/v2', 
            statusCode: '500',
        )
    );
}

void stackTraceMethod() {
    logger.stackTrx(StackTrace.current);
}

void debugMethod() {
    logger.info("This is a log", header: "Debug Method");
}
```

## Author ✒️

* **William Andreu** - *Hybrid TechLead* - [william@rudo.es](william@rudo.es)
---

With ❤️ by RudoApps Flutter Team 😊

![Rudo Apps](https://rudo.es/wp-content/uploads/logo-rudo.svg)