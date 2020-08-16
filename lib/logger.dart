import 'dart:developer' as developer;

class Logger {
  void log(var message) {
    developer.log(
      message.toString(),
      name: '\x1B[33m' + "Musixmatch",
    );
  }

    void loginfo(String message) {
    developer.log(
      message,
      name: '\x1B[36m' + "Musixmatch",
    );
  }

  void logError(String message, [var error]) {
    developer.log(
      message,
      name: '\x1B[31m' + '⚠ Musixmatch',
      error: '\x1B[93m' + error,
      level: 4,
    );
  }
}
