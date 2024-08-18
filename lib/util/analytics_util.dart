import 'package:firebase_analytics/firebase_analytics.dart';

class Events {
  static const eventSearch = 'event_search';
  static const eventScreenOpen = 'event_screen_open';
  static const registerStart = 'wristband_register_start';
  static const registerPersonalInfoDone = 'register_personal_info_done';
  static const registerCardAdded = 'register_card_added';
  static const registerPaymentInfoDone = 'register_payment_info_done';
  static const registerPinAdded = 'register_pin_added';
  static const registerFinish = 'register_finish';
  static const registerCancel = 'register_cancel';
}

Future logEventSearchEvent(String query) async {
  await FirebaseAnalytics.instance.logEvent(
    name: Events.eventSearch,
    parameters: {
      'query': query,
    },
  );
}

Future logEventScreenOpenEvent(String eventId) async {
  await FirebaseAnalytics.instance.logEvent(
    name: Events.eventScreenOpen,
    parameters: {
      'eventId': eventId,
    },
  );
}

Future logRegisterStartEvent(String eventId) async {
  await FirebaseAnalytics.instance.logEvent(
    name: Events.eventScreenOpen,
    parameters: {
      'eventId': eventId,
    },
  );
}

Future logRegisterPersonalInfoDoneEvent(String eventId) async {
  await FirebaseAnalytics.instance.logEvent(
    name: Events.registerPersonalInfoDone,
    parameters: {
      'eventId': eventId,
    },
  );
}

Future logRegisterCardAddedEvent(String eventId) async {
  await FirebaseAnalytics.instance.logEvent(
    name: Events.registerCardAdded,
    parameters: {
      'eventId': eventId,
    },
  );
}

Future logRegisterPaymentInfoDoneEvent(String eventId) async {
  await FirebaseAnalytics.instance.logEvent(
    name: Events.registerPaymentInfoDone,
    parameters: {
      'eventId': eventId,
    },
  );
}

Future logRegisterPinAddedEvent(String eventId) async {
  await FirebaseAnalytics.instance.logEvent(
    name: Events.registerPinAdded,
    parameters: {
      'eventId': eventId,
    },
  );
}

Future logRegisterFinishEvent(String eventId) async {
  await FirebaseAnalytics.instance.logEvent(
    name: Events.registerFinish,
    parameters: {
      'eventId': eventId,
    },
  );
}

Future logRegisterCancelEvent(String eventId) async {
  await FirebaseAnalytics.instance.logEvent(
    name: Events.registerCancel,
    parameters: {
      'eventId': eventId,
    },
  );
}
