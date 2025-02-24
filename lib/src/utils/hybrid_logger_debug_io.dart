import 'dart:developer';

/// Function that will log the message on the console.
void outputLog(String message) {
  final StringBuffer buffer = StringBuffer();
  message.split('\n').forEach(buffer.writeln);
  log(buffer.toString());
}
