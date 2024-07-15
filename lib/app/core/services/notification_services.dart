import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static Future<void> initLocalNotification() async {
    await AwesomeNotifications().initialize(
      // 'resource://drawable/icon_notification',
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Channel',
          channelDescription: 'Notificacion para recordar cita',
          playSound: true,
          defaultRingtoneType: DefaultRingtoneType.Alarm,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Public,
          enableLights: true,
          enableVibration: true,
          channelShowBadge: true,
        )
      ],
      debug: true,
    );
  }

  static Future<void> myNotifyScheduleInHours({
    required int id,
    required DateTime timeSelected,
    required String title,
    required String msg1,
    required String msg2,
    bool repeatNotif = false,
  }) async {
    DateTime nowDate = timeSelected.subtract(const Duration(minutes: 0));
    log("La notificacion se mostrar a las: $nowDate");
    await AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
        day: nowDate.day,
        month: nowDate.month,
        year: nowDate.year,
        hour: nowDate.hour,
        minute: nowDate.minute,
        repeats: repeatNotif,
      ),
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: '${Emojis.time_alarm_clock} $title',
        body: '$msg1 - $msg2',
        category: NotificationCategory.Alarm,
        notificationLayout: NotificationLayout.Default,
        backgroundColor: Colors.red[100],
        // largeIcon: 'asset://assets/icons_launcher/icon_launcher.png',
        roundedLargeIcon: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'DONE',
          label: 'Hecho',
          actionType: ActionType.Default,
        )
      ],
    );
  }

  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  static Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }
}
