import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:iub_transport_system/Services/NOTI/screens/detail_screen.dart';

import 'firebase_notification_handler.dart';


class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseNotifications firebaseNotifications = FirebaseNotifications();
  final Stream<QuerySnapshot> notificationStream = FirebaseFirestore.instance
      .collection('notifications')
      .snapshots();
  CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications');
  @override
  void initState() {
    WidgetsBinding.instance!.addPersistentFrameCallback((timeStamp) async {
      firebaseNotifications.setupFirebase(context);
    });
    super.initState();
    // get count notification unread from firebase
    notifications.where("isRead", isEqualTo: false).get().then((value) {
      // print("get in background mode ${value.docs.length}");
      FlutterAppBadger.updateBadgeCount(value.docs.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      // navigatorKey: GlobalVariable.navState,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        // GetPage(name: '/details', page: () => NotificationDetail()),
        // GetPage(name: '/', page: () => MyApp()),

      ],
      home: Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
        ),
          body: StreamBuilder<QuerySnapshot>(
        stream: notificationStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading.."));
          }

          return new ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return GestureDetector(
                child: Card(
                  color:data['isRead'] ? Colors.white : Colors.blue,
                  child: new ListTile(
                    leading:new Text(data['ref_id']),
                    title: new Text(data['title']),
                    subtitle: new Text(data['body']),
                    trailing: TextButton(child: Text("Delete",style: TextStyle(color: Colors.red),),onPressed: (){
                      notifications.doc(document.id).delete().then((value) {
                        notifications.where("isRead", isEqualTo: false).get().then((value) {
                          // print("get in background mode ${value.docs.length}");
                          FlutterAppBadger.updateBadgeCount(value.docs.length);
                        });
                      });
                    },),
                  ),
                ),
                onTap: () {
                  Get.to(NotificationDetail(refId: data['ref_id']));
                },
              );
            }).toList(),
          );
        },
      ),
      ),
    );
  }
}


CollectionReference notifications =
    FirebaseFirestore.instance.collection('notifications');
  Future<void> updateBadge(RemoteMessage message) async {
    // for IOS we don't need to initializeApp for firebase
    // but for android it's doesn't work if don't initializeApp
    if (Platform.isAndroid) {
      await Firebase.initializeApp();
    }
    // var data = message.data['data'];
    notifications.add({
      'title': message.data['title'], // John Doe
      'body': message.data['body'], // Stokes and Sons
      'isRead': false,
      'ref_id':message.data['ref_id']
    }).catchError((error) => print('Failed to add user: $error'));
    notifications.where("isRead", isEqualTo: false).get().then((value) {
      FlutterAppBadger.updateBadgeCount(value.docs.length);
    });
    // FirebaseNotifications.showNotification(data['title'], data['body']);

}

Future<void> _backgroundHandler(RemoteMessage message) async {
  updateBadge(message);
}
