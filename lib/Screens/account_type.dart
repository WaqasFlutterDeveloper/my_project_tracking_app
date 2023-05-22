// import 'package:flutter/material.dart';
// import 'package:iub_transport_services/components/roundedButtonAccountType.dart';
// import '../components/roundedButtonAccountType.dart';
// import '../const.dart';
// import 'Sign_Up_Screens/admain_signup.dart';
// import 'Sign_Up_Screens/driver_signup.dart';
// import 'Sign_Up_Screens/student_signup.dart';
// import 'constants.dart';
// class AccountType extends StatefulWidget {
//   // String? role;
//   // AccountType({required Key key, @required this.role}) : super(key: key);
//   @override
//   State<AccountType> createState() => _AccountTypeState();
// }
//
// class _AccountTypeState extends State<AccountType> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kAppBarColour,
//       body: ListView(
//           children: [
//             Padding(
//               padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         child: ClipRRect(
//                             borderRadius: BorderRadius.circular(20.0),
//                             child: Image.asset('images/bus.jpg',height: 155.0, width: 340,fit: BoxFit.cover,)),
//                       ),
//                     ],
//                   ),
//                 SizedBox(height: 3.0,),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Center(
//                       child: Container(
//                         height: 110.0,
//                         // width: 500.0,
//                   // padding: EdgeInsets.symmetric(horizontal: 20.0),
//                         decoration: BoxDecoration(
//                           // color: Colors.blue,
//                             borderRadius: BorderRadius.circular(20.0)
//                         ),
//
//                         child:Center(
//                           child: RichText(
//                           text: TextSpan(
//                             text: 'Select ',
//                             style: TextStyle(
//                                 fontSize: 30.0,
//                                 fontWeight: FontWeight.w900,
//                                 fontFamily: 'sans-serif',
//                                 color: Colors.amber
//                             ),
//                             children: <TextSpan>[
//                               TextSpan(text: 'Your ', style: TextStyle(
//                                   fontSize: 30.0,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'FiraSans ',
//                                   color: Colors.white
//                               ),),
//                               TextSpan(text: 'Rule: ', style: TextStyle(
//                                   fontSize: 30.0,
//                                   fontWeight: FontWeight.w900,
//                                   fontFamily: 'FiraSans ',
//                                   color: Colors.green
//                               ),),
//                             ],
//                           ),
//                         ),
//                         )
//                       ),
//                     ),
//
//                   ],
//                 ),
//                 SizedBox(height: 10.0,),
//                 Row(
//                   children: [
//                     AccountTypeImages(imagePath: 'images/admain.jpg',),
//                     RoundedButtonAccountType(
//                       title: 'SignUp As Admin',
//                       onPressed: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => AdminSignUp(role:'admin')));
//                       },
//                     ),
//
//                   ],
//                 ),
//                 SizedBox(height: 15.0,),
//                 Row(
//                   children: [
//                    AccountTypeImages(imagePath: 'images/drr.png'),
//                     RoundedButtonAccountType(
//                       title: 'SignUp As Driver',
//                       onPressed: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => DriverSignUp(role:'driver')));
//                       },
//                     ),
//
//                 ],),
//                 SizedBox(height: 15.0,),
//                 Row(
//                   children: [
//                    AccountTypeImages(imagePath: 'images/admain.jpg'),
//                     RoundedButtonAccountType(
//                       title: 'SignUp As Student',
//                       onPressed: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => StudentSignUp(role:'student')));
//                       },
//                     ),
//                   ],),
//                ]
//                 ,),
//             )
//           ],
//         ),
//     );
//   }
// }
//
// class AccountTypeImages extends StatelessWidget {
//   AccountTypeImages({required this.imagePath});
//   String? imagePath;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(20.0, 5.0, 40.0, 5.0),
//       child: ClipRRect(
//           borderRadius: BorderRadius.circular(10.0),
//           child: Image.asset(imagePath!,height: 60.0, width: 60,fit: BoxFit.cover,)),
//     );
//   }
// }
//
