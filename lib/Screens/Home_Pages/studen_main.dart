// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../../Drawer/change_password.dart';
// import '../../GoogleMap_Location/student_map_view.dart';
// import '../../const.dart';
// import '../../drawer/drawer_widget/drawer_elements.dart';
// import '../../drawer/help.dart';
// import '../Login_Screen/student_login_screen.dart';
// import '../Student_Main/class_schedule.dart';
// import '../Student_Main/news.dart';
// import '../student_main/bus_ schedule.dart';
// import '../student_main/home.dart';
//
// class StudentPage extends StatefulWidget {
//
//   @override
//   State<StudentPage> createState() => _StudentPageState();
// }
//
// class _StudentPageState extends State<StudentPage> {
//   @override
//   // int currentIndex = 0;
//   int _selectIndex = 0;
//   static List<Widget> _widgetOptions = <Widget>[
//     StudentBussRuteInfo(),
//   ];
//   void _onItemTaped(int index) {
//     setState(() {
//       _selectIndex = index;
//     });
//   }
//
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 4,
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           // backgroundColor: Colors.blueGrey.shade300,
//           appBar: AppBar(
//             elevation: .1,
//             backgroundColor: kAppBarColour,
//             // toolbarHeight: 170,
//             title: Text('IUB Bus Service',style: TextStyle(fontWeight: FontWeight.bold),),
//             titleSpacing: 0,
//             textTheme: TextTheme(
//                 headline1: TextStyle(fontSize: 40.0, color: Colors.red)),
//             actions: [
//               IconButton(
//                   onPressed: () {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => StudentPage() ),
//                           (Route<dynamic> route) => false,
//                     );
//                   },
//                   icon: Icon(
//                     Icons.refresh,
//                   )),
//               SizedBox(
//                 width: 30.0,
//               ),
//               IconButton(
//                   onPressed: () {
//
//                   },
//                   icon: Icon(
//                     Icons.notifications,
//                   )),
//             ],
//             bottom: TabBar(
//               indicatorWeight: 5,
//               indicatorColor: Colors.white,
//               tabs: [
//                 Tab(
//                   icon: Icon(Icons.home,color: Colors.amber,),
//                   text: 'Home',
//                 ),
//                 Tab(
//                   icon: Icon(
//                     Icons.bus_alert_outlined,
//                   ),
//                   text: 'BUS',
//                 ),
//                 Tab(
//                   icon: Icon(Icons.group_work,),
//                   text: 'CLASS',
//                 ),
//                 Tab(
//                   icon: Icon(Icons.newspaper,),
//                   text: 'NEWS',
//                 ),
//               ],
//             ),
//
//             // actionsIconTheme: IconThemeData(color: Colors.black,size: 40),
//             // leading: Icon(Icons.home,size: 30.0,),
//             // leadingWidth: 200,
//           ),
//           drawer: Drawer(
//
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: <Widget>[
//                 createHeader(),
//                 createDrawerItem(icon: Icons.person, text: 'Driver Info',
//                     onTap: (){
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => Help()));
//                     }),
//
//                 createDrawerItem(icon: Icons.password_rounded,text: 'Change Password',
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => ChangePassword()));
//                     }),
//                 createDrawerItem(icon: Icons.report_problem_outlined,text: 'Report & Problem!',
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => Help()));
//                     }),
//                 createDrawerItem(icon: Icons.help,text: 'Help!',
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => Help()));
//                     }),
//                 Divider(),
//                 createDrawerItem(icon: Icons.logout,text: 'LogOut',
//                     onTap: () async{
//                       await FirebaseAuth.instance.signOut();
//                       Navigator.push(context, MaterialPageRoute(
//                           builder: (context) => StudentLoginScreen()));
//                     }),
//                 // _createDrawerItem(icon: Icons.bug_report, text: 'Report an issue'),
//               ],
//             ),
//           ),
//
//           body: TabBarView(children: [
//             // Home(),
//             StudentMapViewPage(),
//             StudentBussRuteInfo(),
//             ClasSchudle(),
//             News(),
//           ],),
//         )
//     );
//   }
// }
//
