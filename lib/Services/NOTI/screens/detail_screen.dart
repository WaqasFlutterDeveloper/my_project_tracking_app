import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

import 'package:get/get.dart';

class NotificationDetail extends StatefulWidget {
  final String refId;
  NotificationDetail({required this.refId});
  @override
  _NotificationDetailState createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  // late Stream<QuerySnapshot> notificationStream;
  CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications');

  @override
  void initState()  {
    print("id ${widget.refId}");
    updateStatus();

    super.initState();
  }



  updateStatus()async{
    await notifications.where("ref_id", isEqualTo: widget.refId).get().then((value) {
      FlutterAppBadger.updateBadgeCount(value.docs.length);
      print("ref id get in detail page ${value.docs[0].id}");
      notifications
          .doc(value.docs[0].id)
          .update({
        'isRead': true // 42
      })
          .then((value) {
        notifications.where("isRead", isEqualTo: false).get().then(
                (value) => FlutterAppBadger.updateBadgeCount(value.docs.length));
      })
          .catchError((error) => print("Failed to add user: $error"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Detail"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .where('ref_id', isEqualTo: widget.refId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return new ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return GestureDetector(
                child: new ListTile(
                  leading: Text(widget.refId),
                  title: new Text(data['title']),
                  subtitle: new Text(data['body']),
                ),
                onTap: () {},
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
