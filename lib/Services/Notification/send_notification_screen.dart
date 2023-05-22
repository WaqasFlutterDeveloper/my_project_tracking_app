import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:iub_transport_system/Services/Notification/notification.dart';
import 'package:iub_transport_system/components/textFieldDesign.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../const.dart';
import 'appTerminate_notification.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('A bg message just showed up :  ${message.messageId}');
// }


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showSpinner=false;

  late TextEditingController _textTitle;
  late TextEditingController _textBody;

  @override
  void dispose() {
    _textTitle.dispose();
    _textBody.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    _textTitle = TextEditingController();
    _textBody = TextEditingController();

    // this is call when app in forground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      LocalNotificationService.createanddisplaynotification(message);
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                  channel.name,
                  // channel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher'),
            ));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('a new sms has been published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(context: context, builder: (_) {
          return AlertDialog(
            title: Text(notification.title.toString()),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.body.toString()),
                ],
              ),
            ),

          );
        });
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
    LocalNotificationService.subscribeAdmin();
  }




  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall:showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kAppBarColour,
          title: Center(child: Text('Notifications')),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(16,50,16,5),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextField(
                    controller: _textTitle,
                    decoration: InputDecoration(labelText: "Enter Title"),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _textBody,
                    decoration: InputDecoration(labelText: "Enter Body"),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (check()) {
                        showSpinner=true;
                        pushNotificationsAllUsers(
                          title: _textTitle.text,
                          body: _textBody.text,
                          channel: "students",
                        );
                      }
                      _textTitle.clear();
                      _textBody.clear();
                    },
                    child: Text('Send Notification'),
                  ),

                  // Row(
                  //   children: [
                  //     SizedBox(width: 8),
                  //     Expanded(
                  //       child:
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 50),
                  // Row(
                  //   children: [
                  //     // Expanded(
                  //     //   child: TextField(
                  //     //     controller: _textToken,
                  //     //     decoration: InputDecoration(
                  //     //         enabled: false,
                  //     //         labelText: "My Token for this Device"),
                  //     //   ),
                  //     // ),
                  //     // SizedBox(width: 8),
                  //     // Container(
                  //     //   width: 50,
                  //     //   height: 50,
                  //     //   child: IconButton(
                  //     //     icon: Icon(Icons.copy),
                  //     //     onPressed: () {
                  //     //       Clipboard.setData(
                  //     //           new ClipboardData(text: _textToken.text));
                  //     //     },
                  //     //   ),
                  //     // )
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<bool> pushNotificationsAllUsers({
    required String title,
    required String body,
    required String channel,
  }) async {
    // FirebaseMessaging.instance.subscribeToTopic("myTopic1");
    showSpinner=true;
    String dataNotifications = '{ '
        ' "to" : "/topics/$channel" , '
        ' "notification" : {'
        ' "title":"$title" , '
        ' "body":"$body" '
        ' } '
        ' } ';
    try{
      var response = await http.post(
        Uri.parse(Constants.BASE_URL),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key= ${Constants.KEY_SERVER}',
        },
        body: dataNotifications,
      ).then((value) {
        Navigator.pop(context);
      });
      print(response.body.toString());

    }catch(e){
      print('error due to some reason');
    }
    return true;
  }

  Future<String> token() async {
    return await FirebaseMessaging.instance.getToken() ?? "";
  }

  // void showNotification() {
  //   setState(() {
  //     _counter++;
  //   });
  //   flutterLocalNotificationsPlugin.show(
  //       0,
  //       "Testing $_counter",
  //       "How you doin ?",
  //       NotificationDetails(
  //           android: AndroidNotificationDetails(
  //               channel.id,
  //               channel.name,
  //               // channel.description,
  //               importance: Importance.high,
  //               color: Colors.blue,
  //               playSound: true,
  //               icon: '@mipmap/ic_launcher')));
  // }

  bool check() {
    if (_textTitle.text.isNotEmpty && _textBody.text.isNotEmpty) {
      return true;
    }
    return false;
  }
}


