import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Drawer/change_password.dart';
import '../../Drawer/contact_us.dart';
import '../../GoogleMap_Location/student_map_view.dart';
import '../../Services/NOTI/screens/detail_screen.dart';
import '../../const.dart';
import '../../drawer/drawer_widget/drawer_elements.dart';
import '../../drawer/help.dart';
import '../Login_Screen/student_login_screen.dart';
import '../Student_Main/class_schedule.dart';
import '../Student_Main/news.dart';
import '../student_main/bus_ schedule.dart';
class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Colors.blueGrey.shade300,
      appBar: AppBar(
        elevation: .1,
        backgroundColor: kAppBarColour,
        // toolbarHeight: 170,
        title: Text('IUB Bus Service',style: TextStyle(fontWeight: FontWeight.bold),),
        titleSpacing: 0,
        textTheme: TextTheme(
            headline1: TextStyle(fontSize: 40.0, color: Colors.red)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => StudentHomeScreen() ),
                      (Route<dynamic> route) => false,
                );
              },
              icon: Icon(
                Icons.refresh,
              )),
          SizedBox(
            width: 30.0,
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationDetail(refId:'f1nJ__YjTO6uEwGMHvH3OW:APA91bEbBsZpGB4djpiX3S3np-lGvXy5prrBfoe93d63Y7I2z3NhWrNr73SyqGqpuH4wxpa15jbXu_tS3ZP5aFsFCqNobOn0IX421aP-HF91Z9pRVXOzjCkoBZSczCqvci25wHvse4px')));
              },
              icon: Icon(
                Icons.notifications,
              )),
        ],
      ),
      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            createHeader(),
            createDrawerItem(icon: Icons.bus_alert_outlined, text: 'Bus Sechedule',
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Help()));
                }),

            createDrawerItem(icon: Icons.group_work, text: 'Class Sechedule',
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Help()));
                }),

            createDrawerItem(icon: Icons.password_rounded,text: 'Change Password',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()));
                }),
            createDrawerItem(icon: Icons.report_problem_outlined,text: 'Report & Problem!',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactUs()));
                }),
            // createDrawerItem(icon: Icons.help,text: 'Help!',
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => Help()));
            //     }),
            Divider(),
            createDrawerItem(icon: Icons.logout,text: 'LogOut',
                onTap: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => StudentLoginScreen()));
                }),
            // _createDrawerItem(icon: Icons.bug_report, text: 'Report an issue'),
          ],
        ),
      ),

      body: StudentMapViewPage(),
    );
  }
}
//
// bottom: TabBar(
// indicatorWeight: 5,
// indicatorColor: Colors.white,
// tabs: [
// Tab(
// icon: Icon(Icons.home,color: Colors.amber,),
// text: 'Home',
// ),
// Tab(
// icon: Icon(
// Icons.bus_alert_outlined,
// ),
// text: 'BUS',
// ),
// Tab(
// icon: Icon(Icons.group_work,),
// text: 'CLASS',
// ),
// Tab(
// icon: Icon(Icons.newspaper,),
// text: 'NEWS',
// ),
// ],
// ),
//
// // actionsIconTheme: IconThemeData(color: Colors.black,size: 40),
// // leading: Icon(Icons.home,size: 30.0,),
// // leadingWidth: 200,