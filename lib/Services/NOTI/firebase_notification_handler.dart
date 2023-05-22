import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:iub_transport_system/Services/NOTI/screens/detail_screen.dart';
import 'package:vibration/vibration.dart';

import 'notification_handler.dart';

class FirebaseNotifications {
  late FirebaseMessaging _messaging;
  int messageCount = 1;
  String lastMessageId = "";
  var globalNotificationId;
  late BuildContext myContext;
  void setupFirebase(BuildContext context) {
    _messaging = FirebaseMessaging.instance;
    NotificationHandler.initNotification(context);
    firebaseCloudMessageListener(context);
    myContext = context;
  }

  CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications');
  CollectionReference lstMobileToken =
  FirebaseFirestore.instance.collection('lst_mobile_token');
  void firebaseCloudMessageListener(BuildContext context) async {
    // request permission
    NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    print("setting ${settings.authorizationStatus}");
    //get token
   var existedToken;
    var currentToken;
    _messaging
        .getToken()
        .then((token) {
      lstMobileToken.doc(token)
          .set({
        'token': token})
          .then((value) => print("Added token successfully"));


        })
        .whenComplete(() => print("subscribe success"));

    FirebaseMessaging.onMessage.listen((remoteMessage) async{
      if ( await Vibration.hasVibrator() ?? false) {
        Vibration.vibrate();
      }
      // print("receive $remoteMessage");
      // print(messageCount +=1);
      // FlutterAppBadger.updateBadgeCount(messageCount ++);
      globalNotificationId = remoteMessage.data['ref_id'];
      if (Platform.isAndroid) {
        if (lastMessageId != remoteMessage.messageId) {
          notifications
              .add({
            'title': remoteMessage.data['title'], // John Doe
            'body': remoteMessage.data['body'], // Stokes and Sons
            'isRead': false,
            'ref_id':remoteMessage.data['ref_id']
          })
              .then((value) => print("User Added"))
              .catchError((error) => print("Failed to add user: $error"));
          // showNotification(
          //     remoteMessage.data['title'], remoteMessage.data['body']);
          //
          // print("last message id $lastMessageId");
          // print("remoteMessage.messageId! ${remoteMessage.messageId!}");
          notifications.where("isRead", isEqualTo: false).get().then(
                  (value) => FlutterAppBadger.updateBadgeCount(value.docs.length));
        }

      }
      if (Platform.isIOS) {
        if (lastMessageId != remoteMessage.messageId) {
          notifications
              .add({
                'title':remoteMessage.data['title'], // John Doe
                'body': "Testing body", // Stokes and Sons
                'isRead': false,
            'ref_id':remoteMessage.data['ref_id']
              })
              .then((value) => print("User Added"))
              .catchError((error) => print("Failed to add user: $error"));
          // showNotification(
          //     remoteMessage.data['title'], remoteMessage.data['body']);
          //
          // print("last message id $lastMessageId");
          // print("remoteMessage.messageId! ${remoteMessage.messageId!}");
          notifications.where("isRead", isEqualTo: false).get().then(
              (value) => FlutterAppBadger.updateBadgeCount(value.docs.length));
        }
      }
      lastMessageId = remoteMessage.messageId!;
    });

      FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
        //delay a bit to get correct notification
        Future.delayed(Duration(seconds: 2), () {
          // we use getX to help for navigate to to detail screen screen without context
          Get.to(NotificationDetail(refId: remoteMessage.data['ref_id']));
        });
      });

  }

  static void showNotification(title, body) async {
    var androidChannel = AndroidNotificationDetails(
        "com.example.flutter_messaging_app", "My channel",
        autoCancel: false,
        ongoing: true,
        importance: Importance.max,
        priority: Priority.high);
    var ios = IOSNotificationDetails();
    var platForm = NotificationDetails(android: androidChannel, iOS: ios);
    await NotificationHandler.flutterLocalNotificationPlugin
        .show(0, title, body, platForm, payload: "my payload");
  }
}
