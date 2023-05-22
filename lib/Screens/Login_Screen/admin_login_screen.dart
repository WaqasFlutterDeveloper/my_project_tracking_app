import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../GoogleMap_Location/student_map_view.dart';
import '../../auth/authentication.dart';
import '../../components/textFieldDesign.dart';
import '../../const.dart';
import '../Home_Pages/admain_main.dart';
import '../Home_Pages/driver_main.dart';
import '../Home_Pages/studen_main.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Sign_Up_Screens/admain_signup.dart';
import '../forget_password.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  AuthByEmail authByEmail = AuthByEmail();
  String email='';
  String password='';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kAppBarColour,
      body: ListView(
        children: [
          Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 15.0),
                  ),
                  Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage('images/iub.png'),
                        )),
                  ),
                  // Padding(padding: EdgeInsets.only(top: 12.0, bottom: 23.0)),
                  SizedBox(height: 20.0,),
                  Center(
                    child: TyperAnimatedTextKit(
                      text: ['The Islamia University'],
                      textStyle: TextStyle(
                        fontSize: 30.0,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FiraSans',
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(38.0, 25.0, 38.0, 10.0),
                  child: Column(
                    children: [
                      TextFieldStyle(hint:'Email', icon:FontAwesomeIcons.idBadge,fieldHeight: 50.0,isBool: false,
                        onChanged: (value){
                          email = value;
                        },),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFieldStyle(hint:'Password', icon:FontAwesomeIcons.key ,fieldHeight: 50.0,isBool: true,
                        onChanged: (value){
                          password = value ;
                        },),
                      Padding(
                        padding: EdgeInsets.fromLTRB(100.0, 15.0, 10.0, 20.0),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
                          },
                          child: Text(
                            'Forget Password!',
                            style:TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'FiraSans',
                              fontWeight: FontWeight.bold,
                              wordSpacing: 2.0,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      WelcomRoundedButton(
                        onPressed: ()async{
                          try {
                            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: email,
                                password: password
                            );

                            if(email == 'admin@gmail.com' && password == '123456'){


                              Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPage()));
                            }if(email == 'admin2@gmail.com' && password == '123456'){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPage()));
                            }
                            else if(email == 'driver@gmail.com' && password == '123456'){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DriverPage()));

                            } else if(email == 'driver1@gmail.com' && password == '123456'){

                              Navigator.push(context, MaterialPageRoute(builder: (context) => DriverPage()));
                            } else if(email == 'driver2@gmail.com' && password == '123456'){

                              Navigator.push(context, MaterialPageRoute(builder: (context) => DriverPage()));
                            } else if(email == 'driver3@gmail.com' && password == '123456'){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DriverPage()));

                            } else if(email == 'waqas@gmail.com' && password == '123456'){

                              Navigator.push(context, MaterialPageRoute(builder: (context) => StudentMapViewPage()));

                            } else if(email == 'student@gmail.com' && password == '123456'){

                              Navigator.push(context, MaterialPageRoute(builder: (context) => StudentMapViewPage()));
                            } else (){
                              print('something  wrong');
                            };

                            // if(credential != null){



                            // FirebaseFirestore.instance.collection("Users").get().then((value){
                            //   if(value.docs.isNotEmpty){
                            //     for(int i = 0; i < value.docs.length; ++i){
                            //
                            //       // Navigator.removeRoute(context, MaterialPageRoute(builder: (context) => AdminPage()));
                            //       // GeoPoint pos =
                            //       // (value.data()['position']['geopoint'] ?? '';
                            //       // print('This is Value of Data <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Data and PopulateMarks');
                            //
                            //       // print(value.docs[i].data());
                            //       // initMarker(value.docs[i].data, value.docs[i].data()['name']);
                            //
                            //       if(value.docs[i].data()['role'] == 'admin'){
                            //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminPage()));
                            //       }
                            //       else if(value.docs[i].data()['role'] == 'driver'){
                            //         Navigator.push(context, MaterialPageRoute(builder: (context) => DriverPage()));
                            //         return null;
                            //       }
                            //       else if(value.docs[i].data()['role']=='student'){
                            //         Navigator.push(context, MaterialPageRoute(builder: (context) => StudentPage()));
                            //         return null;
                            //       }
                            //       else {
                            //         print('Not Exist Data');
                            //         Navigator.push(context, MaterialPageRoute(builder: (context) => AccountType()));
                            //         return null;
                            //       }
                            //
                            //     }
                            //   }
                            // });

                            // }





                            // final _auth = FirebaseAuth.instance;
                            // final db =await FirebaseFirestore.instance;
                            // final  user =await _auth.currentUser;
                            // final userUid= user!.uid;
                            //   db.collection("AdminData").where("role", isEqualTo: "admin" ).get().then((snapshot){
                            //     setState(() {
                            //       if(snapshot['role'] == 'admin'){
                            //         Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPage()));
                            //       }
                            //       else if(snapshot.value['role'] == 'driver'){
                            //         Navigator.push(context, MaterialPageRoute(builder: (context) => DriverPage()));
                            //       }
                            //       else if(snapshot.value['role'] == 'student'){
                            //         Navigator.push(context, MaterialPageRoute(builder: (context) => StudentPage()));
                            //       }
                            //     });
                            //   });
                          }
                          // else if(uid == uid){
                          //   FirebaseFirestore.instance.
                          //   collection("locations").where("role", isEqualTo: "driver" ).get().then((value){
                          //     if(value.docs.isNotEmpty){
                          //       Navigator.push(context, MaterialPageRoute(builder: (context) => DriverPage()));
                          //     }
                          //   });
                          // }
                          // else if(uid == uid){
                          //   FirebaseFirestore.instance.
                          //   collection("StudentData").where("role", isEqualTo: "student" ).get().then((value){
                          //     if(value.docs.isNotEmpty){
                          //       Navigator.push(context, MaterialPageRoute(builder: (context) => StudentPage()));
                          //     }
                          //   });
                          // }
                          // else{
                          //   print('Any Issue');
                          // }

                          // }
                          on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 15.0, 10.0, 10.0),
                        child:Row(
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                wordSpacing: 2.0,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            MaterialButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AdminSignUp(role:'admin')));
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => AccountType()));
                              },
                              child:Text(
                                " SignUp!",
                                style: TextStyle(
                                  fontFamily: 'FiraSans',
                                  // decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                  decorationThickness: 3.0,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lime,
                                ),
                                textAlign: TextAlign.left,
                              ),

                            )
                          ],
                        ),


                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}




// this will show error message if any face error
// displatTostMessage(String message , BuildContext context){
//   FlutterToast(msg:message);
// }


class WelcomRoundedButton extends StatelessWidget {
   WelcomRoundedButton({required this.onPressed,}) ;

   Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      // width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white60,
      ),
      child: MaterialButton(
        onPressed: () {
          onPressed!();
        },
        minWidth: 330.0,
        child: TyperAnimatedTextKit(
          text:['Login'],
         textStyle:TextStyle(
             fontFamily: 'FiraSans',
             fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}





