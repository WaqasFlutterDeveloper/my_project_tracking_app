import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Drawer/change_password.dart';
import '../../Drawer/contact_us.dart';
import '../../GoogleMap_Location/student_map_view.dart';
import '../../Services/Notification/send_notification_screen.dart';
import '../../drawer/drawer_widget/drawer_elements.dart';
import '../../drawer/help.dart';
import '../Login_Screen/driver_login_screen.dart';
import '../constants.dart';
import '../home_pages/studentViewLocationPage.dart';
import 'bus_sechdule.dart';
import 'class_sechedule.dart';
import 'driver_info.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Dashboard"),
            // SizedBox(width: 30.0,),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => StudentMapViewPage()));
            }, icon: const Icon(Icons.bus_alert_sharp)),
          ],
        ),
        elevation: .1,
        backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
      ),
      drawer:Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            createHeader(),
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
            Divider(),
            createDrawerItem(icon: Icons.logout,text: 'LogOut',
                onTap: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DriverLoginScreen()));
                }),
            // _createDrawerItem(icon: Icons.bug_report, text: 'Report an issue'),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            // makeDashboardItem(, ),
            // makeDashboardItem(, ,),
            // makeDashboardItem(, ),

            makeDashbordItem(
                title: 'Class Schedule',
                icon: Icons.alarm,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassSechedule()));
                  print('clss');
                }),
            makeDashbordItem(
                title: "Bus Schedule",
                icon: Icons.directions_bus,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FirstPage()));
                  print('bus');
                }),
            makeDashbordItem(
                title: "Message",
                icon: Icons.message,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage()));
                }),
            makeDashbordItem(
                title: "Driver Info",
                icon: Icons.man,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DriverInfo()));
                  print('dr.info');
                }),
          ],
        ),
      ),
    );
  }
}





class makeDashbordItem extends StatelessWidget {
  makeDashbordItem(
      {required this.title, required this.icon, required this.onPressed});
  IconData? icon;
  String? title;
  Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {
              onPressed!();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title!,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
}

// Card makeDashboardItem(String title, IconData icon, Function onPressed) {
//   return Card(
//       elevation: 1.0,
//       margin: new EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
//         child: new InkWell(
//           onTap: () {
//             // onPressed();
//             print('presed');
//           },
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisSize: MainAxisSize.min,
//             verticalDirection: VerticalDirection.down,
//             children: <Widget>[
//               SizedBox(height: 50.0),
//               Center(
//                   child: Icon(
//                 icon,
//                 size: 40.0,
//                 color: Colors.black,
//               )),
//               SizedBox(height: 20.0),
//               new Center(
//                 child: new Text(title,
//                     style: new TextStyle(fontSize: 18.0, color: Colors.black)),
//               )
//             ],
//           ),
//         ),
//       ));
// }
