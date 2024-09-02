import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class TtsBroadCastEvent {
  String text;

  TtsBroadCastEvent(this.text);
}

class ShowToastEvent {
  String msg;

  ShowToastEvent(this.msg);
}
