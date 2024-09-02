import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class TtsBroadCastEvent {
  String text;

  TtsBroadCastEvent(this.text);
}

class ToastEvent {
  String msg;

  ToastEvent(this.msg);
}

class ErrorNotificationEvent {
  String msg;
  String? detail;

  ErrorNotificationEvent(this.msg, [this.detail]);
}
