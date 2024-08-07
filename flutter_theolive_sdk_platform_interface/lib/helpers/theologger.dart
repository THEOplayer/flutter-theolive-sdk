import 'package:flutter/foundation.dart';

/**
 * Logger class to capture logs and exceptions
 * NOTE:
 * - Experimental
 * - Only used to catch PlatformExceptions for now
 */
class THEOLogger {

  THEOLoggerCallback? _loggerCallback;

  THEOLoggerCallback? get logger {
    return _loggerCallback;
  }

  void set logger(THEOLoggerCallback? callback) {
    _loggerCallback = callback;
  }

  static final THEOLogger instance = THEOLogger._constructor();
  THEOLogger._constructor();

  void _log(Exception e, StackTrace? stackTrace) {
    _loggerCallback?.onException(e, stackTrace ?? StackTrace.current );
  }

  bool isListening() {
    return _loggerCallback != null;
  }

}

abstract class THEOLoggerCallback {
  void onException(Exception e, StackTrace stackTrace);
}

void exceptionHandler({required String tag, required Exception exception, String? context = null, StackTrace? stacktrace = null}) {
  if (kDebugMode) {
    throw exception;
  } else {
    final prefix = "[$tag]";
    final ctx = context != null ? "[C:$context]" : "";
    var logMessage = "THEOLogger$prefix$ctx - Exception happened: $exception";
    if (!THEOLogger.instance.isListening()) {
      logMessage += " - for more info, attach a logger to THEOLogger.instance!";
    }
    print(logMessage);
    THEOLogger.instance._log(exception, stacktrace);
  }
}