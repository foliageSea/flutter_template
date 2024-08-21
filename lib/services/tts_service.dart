import 'package:flutter_template/events/events.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class TtsService extends GetxService {
  static TtsService get to => Get.find();

  FlutterTts? flutterTts;

  void broadCast(String text) {
    eventBus.fire(TtsBroadCastEvent(text));
  }

  Future<TtsService> init() async {
    try {
      flutterTts = FlutterTts();

      await flutterTts?.setLanguage("zh-CN");

      await flutterTts?.setSpeechRate(0.5);

      await flutterTts?.setVolume(1.0);

      await flutterTts?.setPitch(1.0);
    } catch (e) {
      talker.error('TtsService 初始化出错', e);
    }

    eventBus.on<TtsBroadCastEvent>().listen((event) async {
      try {
        await flutterTts?.stop();
        await flutterTts?.speak(event.text);
      } catch (_) {}
    });

    return this;
  }
}
