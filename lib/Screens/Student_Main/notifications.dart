import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Services/NOTI/screens/detail_screen.dart';

class Notification extends StatefulWidget {
  const Notification({Key? key}) : super(key: key);

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  final Stream<QuerySnapshot> notificationStream = FirebaseFirestore.instance
      .collection('notifications')
      .snapshots();
  CollectionReference notifications =
  FirebaseFirestore.instance.collection('notifications');
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
