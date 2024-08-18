import 'package:bugsnag_flutter/bugsnag_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void recordError(dynamic e, StackTrace? stack) {
  FirebaseCrashlytics.instance.recordError(e, stack);
  bugsnag.notify(e, stack);
}