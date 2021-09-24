import 'dart:math';

class Logger {
  static bool _enabled = false;

  static void disable() {
    _enabled = false;
    print("Logger disabled");
  }

  static void enable() {
    _enabled = true;
    print("Logger enabled");
  }

  static void logSimple(String log) {
    if (_enabled) print(log);
  }

  static void logError(String log) {
    if (_enabled) print('======= ERROR =======\n$log');
  }
}
