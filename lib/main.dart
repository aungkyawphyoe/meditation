import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'app.dart';
import 'l10n/app_localizations.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  const androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const darwinSettings = DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  const initSettings = InitializationSettings(
    android: androidSettings,
    iOS: darwinSettings,
    macOS: darwinSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(initSettings);

  const androidChannel = AndroidNotificationChannel(
    'daily_reminders',
    'Daily Reminders',
    importance: Importance.high,
    description: 'Daily meditation reminders',
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidChannel);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(alert: true, badge: true, sound: true);

  final prefs = await SharedPreferences.getInstance();
  final localeCode = prefs.getString('selected_locale') ?? 'en';
  final locale = Locale(localeCode);

  await _scheduleDailyReminder(locale);

  runApp(const ProviderScope(child: App()));
}

Future<void> _scheduleDailyReminder(Locale locale) async {
  await flutterLocalNotificationsPlugin.cancel(0);

  final now = tz.TZDateTime.now(tz.local);
  var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 9);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }

  final localizations = await AppLocalizations.delegate.load(locale);
  final title = localizations.notificationTitle;
  final body = localizations.notificationBodyGeneric;

  const notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'daily_reminders',
      'Daily Reminders',
      channelDescription: 'Daily meditation reminders',
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
    macOS: DarwinNotificationDetails(),
  );

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    body,
    scheduledDate,
    notificationDetails,
    androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.time,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}
