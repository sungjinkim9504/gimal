import 'package:flutter/foundation.dart';

void logDebug(String message) {
  if (kDebugMode) debugPrint('[DEBUG] $message');
}

void logError(String message, [Object? error, StackTrace? stackTrace]) {
  if (kDebugMode) debugPrint('[ERROR] $message${error != null ? ': $error' : ''}');
}

void logInfo(String message) {
  if (kDebugMode) debugPrint('[INFO] $message');
}
