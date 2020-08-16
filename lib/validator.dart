import 'package:musixmatch/logger.dart';

class Validator {
  Logger _l = Logger();
  bool isLogging = false;

  void validateStatus(int status) {
    switch (status) {
      case 200:
        if (isLogging) _l.log('200: The request was successful');
        break;
      case 400:
        _l.logError(
            '400: The request had bad syntax or was inherently impossible to be satisfied.');
        break;
      case 401:
        _l.logError(
            '401: Authentication failed, probably because of invalid/missing API key.');
        break;
      case 402:
        _l.logError(
            '402: The usage limit has been reached, either you exceeded per day requests limits or your balance is insufficient.');
        break;
      case 403:
        _l.logError('403: You are not authorized to perform this operation.');
        break;
      case 404:
        _l.logError('404: The requested resource was not found.');
        break;
      case 405:
        _l.logError('405: The requested method was not found.');
        break;
      case 500:
        _l.logError('500: Ops. Something were wrong.');
        break;
      case 503:
        _l.logError(
            '503: Our system is a bit busy at the moment and your request can’t be satisfied.');
        break;
      default:
        _l.log('No value was given');
    }
  }
}
