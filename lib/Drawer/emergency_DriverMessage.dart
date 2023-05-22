import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iub_transport_system/components/roundedButtonAccountType.dart';

import '../../Screens/Home_Pages/driver_main.dart';
import '../../Services/Notification/notification.dart';
import '../../const.dart';
import 'package:http/http.dart' as http;
class EmergencyDriverMessage extends StatefulWidget {
  String? bus;
   EmergencyDriverMessage({required this.bus}) ;

  @override
  State<EmergencyDriverMessage> createState() => _EmergencyDriverMessageState();
}

class _EmergencyDriverMessageState extends State<EmergencyDriverMessage> {
  @override

  Future<bool> pushNotificationsAll({
    required String title,
    required String body,
  }) async {
    // FirebaseMessaging.instance.subscribeToTopic("myTopic1");
    String dataNotifications = '{ '
        ' "to" : "/topics/all" , '
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
  final uid = FirebaseAuth.instance.currentUser?.uid;
  addNotification(
  String title,
   String body,
      )async{
    FirebaseFirestore.instance.collection('notifications').doc(uid).set({
      'title':title.toString(), // John Doe
      'body': body.toString(), // Stokes and Sons
      'isRead': false,
      'uid':uid,
    }).then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  @override
  initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:kBColour,
      appBar: AppBar(
        backgroundColor: kAppBarColour,
        title: Text('Emargency Message'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 150.0, 10.0, 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10.0,),
                Row(
                  children: [
                    AccountTypeImages(imagePath: 'images/stop.png',),
                    RoundedButtonAccountType(
                      title: 'Out Of Service',
                      onPressed: (){
                        pushNotificationsAll(
                          title: "Driver's Message bus#:${widget.bus}",
                          body: "Out Of Service bus.",
                        );
                        addNotification("Driver's Message bus#:${widget.bus}",
                          "Out Of Service bus.");
                      },
                    ),

                  ],
                ),
                SizedBox(height: 40.0,),
                Row(
                  children: [
                    AccountTypeImages(imagePath: 'images/traffic.png'),
                    RoundedButtonAccountType(
                      title: 'Stuck In Traffic',
                      onPressed: (){
                        pushNotificationsAll(
                          title: "Driver's Message bus#:${widget.bus}",
                          body: "Bus Stuck In Traffic.",
                        );
                        addNotification("Driver's Message bus#:${widget.bus}",
                            "Bus Stuck In Traffic."
                        );
                      },
                    ),

                  ],),
                SizedBox(height: 40.0,),
                Row(
                  children: [
                    AccountTypeImages(imagePath: 'images/tools.png'),
                    RoundedButtonAccountType(
                      title: 'Mechanical Fault',
                      onPressed: (){
                        pushNotificationsAll(
                          title: "Driver's Message bus#:${widget.bus}",
                          body: "Mechanical Fault in bus.",
                        );
                        addNotification("Driver's Message bus#:${widget.bus}",
                            "Mechanical Fault in bus.");
                      },
                    ),
                  ],),
              ]
              ,),
          ),
        ],
      ),
    );
  }
}
class AccountTypeImages extends StatelessWidget {
  AccountTypeImages({required this.imagePath});
  String? imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 5.0, 40.0, 5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(imagePath!,height: 60.0, width: 60,fit: BoxFit.cover,)),
    );
  }
}
