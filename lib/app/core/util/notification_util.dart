import '../services/notification_services.dart';
import 'convert_types_util.dart';

class NotificationUtil {
  static Future<void> showLocalNotification(String hourTaskSelected,
      String dayTaskSelected, String taskTitle, int timeStamp) async {
    // TODO: implement showLocalNotification

    DateTime dateHourTask =
        ConvertTypesUtil.joinDateHour(dayTaskSelected, hourTaskSelected);
    await NotificationService.myNotifyScheduleInHours(
        id: timeStamp,
        title: taskTitle,
        msg1: hourTaskSelected,
        msg2: dayTaskSelected,
        timeSelected: dateHourTask);
  }

  static Future<void> cancelNotification(int id) async {
    await NotificationService.cancelNotification(id);
  }
}