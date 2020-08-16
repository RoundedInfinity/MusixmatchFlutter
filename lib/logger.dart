import 'dart:developer' as developer;

class Logger {
  void log(String message) {
    developer.log(
      message,
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
      error: error,
      level: 4,
    );
  }
}
