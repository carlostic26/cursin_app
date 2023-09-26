import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static Future<void> requestPermissionLocalNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  static Future<void> initializeLocalNotificatios() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      //
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> showLocalNotification({
    required int id,
    String? title,
    String? body,
    String? data,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: false,
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails,
        payload: data);
  }

  Future<void> scheduleNotificationAtSpecificTime({
    required int id,
    String? title,
    String? body,
    String? data,
  }) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Configura los detalles de la notificación.
    const androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: false,
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    // Calcula la fecha y hora para el próximo jueves a las 9:13 AM.
    final now = DateTime.now();
    final nextThursday =
        now.add(Duration(days: 6 - now.weekday)); // Avanzar al próximo jueves.
    final notificationTime = DateTime(
      nextThursday.year,
      nextThursday.month,
      nextThursday.day,
      9, // Hora
      13, // Minutos
    );

    // Programa la notificación.
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id, // ID de la notificación
      title,
      body,
      tz.TZDateTime.from(notificationTime, tz.local),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> scheduleNotificationIn5Seconds({
    required int id,
    String? title,
    String? body,
    String? data,
  }) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Configura los detalles de la notificación.
    const androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: false,
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    // Calcula la fecha y hora para 5 segundos en el futuro.
    final now = DateTime.now();
    final notificationTime =
        now.add(Duration(seconds: 5)); // 5 segundos en el futuro.

    // Programa la notificación.
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id, // ID de la notificación
      title,
      body,
      tz.TZDateTime.from(notificationTime, tz.local),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
