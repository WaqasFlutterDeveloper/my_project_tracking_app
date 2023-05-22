
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler{
  static final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

  static late BuildContext myContext;
  static Future<void> initNotification(BuildContext context) async {
    myContext = context;
    var initAndroid = AndroidInitializationSettings("@drawable/launch_background");

    var initIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );

    var initSetting = InitializationSettings(android: initAndroid,iOS: initIOS);
    flutterLocalNotificationPlugin.initialize(initSetting,onSelectNotification: onSelectNotification);

  }
  static Future onSelectNotification(String? payload){
    throw payload!;
    // print("get payload ${payload!}");

  }
  static Future onDidReceiveLocalNotification(int? id,String? title,String? body, String? payload) async {
    showDialog(context: myContext, builder: (context) => CupertinoAlertDialog(

      title: Text(title!),
      content: Text(body!),

      actions: [
      CupertinoDialogAction(
        isDefaultAction: true,
        child: Text("OK"),
        onPressed:   () => Navigator.of(context,rootNavigator: true).pop(),
      )
    ],)
    );
  }


}