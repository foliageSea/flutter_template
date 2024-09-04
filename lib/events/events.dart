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

class SnackBarEvent {
  final String msg;
  final String? detail;

  SnackBarEvent(this.msg, {this.detail});
}
