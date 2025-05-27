import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

enum CustomNotificationChannel {
  andon,
}

abstract class NotificationsUtilAble {
  void init();

  void setListeners();

  Future requestPermission();

  Future createNotification({
    required CustomNotificationChannel channelKey,
    String? title,
    String? body,
  });
}

class NotificationsUtil implements NotificationsUtilAble {
  static NotificationsUtil? _notificationsUtil;

  NotificationsUtil._();

  factory NotificationsUtil() {
    _notificationsUtil ??= NotificationsUtil._();
    return _notificationsUtil!;
  }

  final Map<CustomNotificationChannel, NotificationChannel>
      _notificationChannels = {
    CustomNotificationChannel.andon: NotificationChannel(
      channelKey: 'andon_channel',
      channelName: '安灯通知',
      channelDescription: '安灯通知渠道',
      defaultColor: const Color(0xFF9D50DD),
      ledColor: Colors.white,
      importance: NotificationImportance.High,
    )
  };

  String getNotificationChannelKey(CustomNotificationChannel channelKey) {
    return _notificationChannels[channelKey]?.channelKey ?? '';
  }

  @override
  void init() {
    List<NotificationChannel> channels = _notificationChannels.values.toList();

    AwesomeNotifications().initialize(
      null,
      channels,
      debug: false,
    );
  }

  @override
  Future setListeners() async {
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
  }

  @override
  Future requestPermission() async {
    var isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  @override
  Future createNotification({
    required CustomNotificationChannel channelKey,
    String? title,
    String? body,
  }) async {
    var id = DateTime.now().millisecond;
    return AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: getNotificationChannelKey(channelKey),
        actionType: ActionType.Default,
        title: title,
        body: body,
        wakeUpScreen: true,
      ),
    );
  }
}

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
    //     '/notification-page',
    //     (route) =>
    //         (route.settings.name != '/notification-page') || route.isFirst,
    //     arguments: receivedAction);
  }
}
