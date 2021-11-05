import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotificationAPI{
  static final _notification = FlutterLocalNotificationsPlugin();
  static Future showNotification({int id=0,String title,String body,String payload }) async => _notification.show(id, title, body, await notificationDetails(), payload: payload);

  static Future notificationDetails() async{
    return NotificationDetails(android: AndroidNotificationDetails("channelId", "channelName"));
  }
}