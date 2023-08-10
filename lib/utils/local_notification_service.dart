import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _notificationsPlugin.initialize(initializationSettings,onSelectNotification: (String? route) async{
      // if(route == "currentLoad"){
      //   Provider.of<LoadProvider>(context, listen: false).getCurrentLoad();
      // }
      // if(route != null){
      //   Navigator.of(context).pushNamed(route);
      // }
    });
  }

  static void display(RemoteMessage? message) async {

    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/1000;

      AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
          "eleven_organizer1",
          "organizer",
          "organizer app",
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          sound: RawResourceAndroidNotificationSound("notification"),
          icon: "@mipmap/ic_launcher");

      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails
      );

      await _notificationsPlugin.show(
        id,
        message?.notification!.title,
        message?.notification!.body,
        notificationDetails,
        payload: 'Custom_Sound',
      );
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}