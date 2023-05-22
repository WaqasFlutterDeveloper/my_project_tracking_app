import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../auth/authentication.dart';
import '../../components/textFieldDesign.dart';
import '../../const.dart';
import '../Home_Pages/studen_main.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Home_Pages/student_mainPage.dart';
import '../Sign_Up_Screens/student_signup.dart';
import '../forget_password.dart';
import 'admin_login_screen.dart';


class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({Key? key}) : super(key: key);

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  AuthByEmail authByEmail = AuthByEmail();
  bool showSpinner=false;
  String email='';
  String password='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBarColour,
      body: ModalProgressHUD(
        inAsyncCall:showSpinner,
        child: ListView(
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
                            onPressed: ()async {

                              if(email == null || email.isEmpty){
                                displatTostMessage('Please Enter email', context);
                              }
                              else if(password == null || password.isEmpty){
                                displatTostMessage('Please Enter password', context);
                              } else if(password.length<6){
                                displatTostMessage('Please Enter has 6 strength password', context);
                              }else if(!email.contains('@')){
                                displatTostMessage('Please Enter valid Email', context);
                              }else{
                                setState((){
                                  showSpinner = true;
                                });
                                try {
                                  final credential = await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                      email: email,
                                      password: password
                                  );
                                  // Center(child: CircularProgressIndicator());

                                  if (credential != null) {
                                    // Fluttertoast.showToast(
                                    //   msg: 'show sms which you want',
                                    //   backgroundColor: Colors.grey,
                                    // );
                                    erroMessage('You have successfully login');
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => StudentHomeScreen()));
                                  }
                                  setState((){
                                    showSpinner = false;
                                  });
                                }
                                on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    // displatTostMessage('No user found for that email please signUp', context);
                                    setState((){
                                      showSpinner = false;
                                    });
                                    erroMessage('No user found for that email please signUp');
                                    print('No user found for that email.');
                                  } else if (e.code == 'wrong-password') {
                                    // displatTostMessage('Wrong password provided for that user', context);
                                    setState((){
                                      showSpinner = false;
                                    });
                                    erroMessage('Wrong password provided for that user');
                                    print('Wrong password provided for that user.');
                                  }
                                }
                              }

                            }
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => StudentSignUp(role:'student')));
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
      ),
    );
  }
  displatTostMessage(String message , BuildContext context){
    Fluttertoast.showToast(msg:message, backgroundColor: Colors.grey,);
  }

  erroMessage(String message){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,style: TextStyle(fontSize: 25.0),)));
  }
}

