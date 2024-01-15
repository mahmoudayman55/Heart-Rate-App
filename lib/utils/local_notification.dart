import 'package:notification_permissions/notification_permissions.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static final _notification = FlutterLocalNotificationsPlugin();

  static const _androidNotificationDetails = AndroidNotificationDetails(
    "8", "noti1",
    icon: "@mipmap/ic_launcher",
    sound: RawResourceAndroidNotificationSound('sample'),
    playSound: true,
    audioAttributesUsage: AudioAttributesUsage.alarm,
    priority: Priority.max,
    importance: Importance.max,
  );

  static const _iOSNotificationDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
    subtitle: 'Notification Subtitle',
  );
  static Future<bool> getNotificationStatus() async {
    PermissionStatus permissionStatus =
    await NotificationPermissions.getNotificationPermissionStatus();
    return permissionStatus==PermissionStatus.granted;
  }
  static requestNotification () {
    NotificationPermissions.requestNotificationPermissions(
        iosSettings: const NotificationSettingsIos(
            sound: true, badge: true, alert: true),openSettings:true )
        .then((_) {

    });
  }

  static const _notificationDetails = NotificationDetails(
    android: _androidNotificationDetails,
    iOS: _iOSNotificationDetails,
  );

  static Future init({bool initSchedule = false}) async {
    await _notification.initialize(const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher")),);
  }

  static Future showNotification(
      {int? id = 0, String? title, String? body, String? payload}) async {
    if (id != null) {
      _notification.show(id, title, body, _notificationDetails,
          payload: payload);

    }
  }

  static Future cancelNotification(int id) async {
    await _notification.cancel(id);
  }

  static Future showScheduledNotification({int? id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime dateTime}) async {
    if (id != null) {
      await _notification.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(dateTime, tz.local),
        _notificationDetails,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
      );

    }
  }
}
