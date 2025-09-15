import 'package:flutter/material.dart';
import 'package:hybrid_logger_web/logs/hybrid_logger_wrapper.dart';
import 'package:hybrid_logger_web/model/test_model.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final testModel = TestModel();

  @override
  void initState() {
    super.initState();
    HybridLoggerWrapper().logger.debug('This is a debug message');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(
            spacing: 16,
            children: [
              Text('Hybrid Logger Web Example!'),
              ElevatedButton(
                onPressed: () {
                  HybridLoggerWrapper().logger.info('Info button pressed');
                },
                child: const Text('Press me'),
              ),
              ElevatedButton(
                onPressed: () {
                  try {
                    throw Exception('This is a test exception');
                  } catch (e) {
                    HybridLoggerWrapper().logger.error(
                      'An error occurred: $e',
                      stack: StackTrace.current,
                    );
                  }
                },
                child: const Text('Press me to log an error'),
              ),
              ElevatedButton(
                onPressed: () {
                  testModel.stackMethodTest();
                },
                child: const Text('Press me to log current StackTrace'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
