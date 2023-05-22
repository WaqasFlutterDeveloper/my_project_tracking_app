import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../auth/authentication.dart';
import '../../components/roundedLoginButton.dart';
import '../../components/textFieldDesign.dart';
import '../../const.dart';
import '../../providers/student_auth_provider.dart';
import '../Login_Screen/student_login_screen.dart';
import '../home_pages/studen_main.dart';

class StudentSignUp extends StatefulWidget {
  String role;
   StudentSignUp({required this.role});

  @override
  State<StudentSignUp> createState() => _StudentSignUpState();
}

class _StudentSignUpState extends State<StudentSignUp> {
  StudentAuthProvider studentAuthProvider = StudentAuthProvider();
  AuthByEmail authByEmail = AuthByEmail();
  bool showSpinner=false;
  String email='';
  String password='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:kAppBarColour,
      body: ModalProgressHUD(
        inAsyncCall:showSpinner,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(38.0, 30.0, 38.0, 25.0),
                  child: Container(
                    height: 120.0,
                    // width: 10.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(50.0),

                        image: DecorationImage(
                          image: AssetImage('images/admain.jpg'),
                        )),
                    // child: CircleAvatar(
                    //   radius: 110.0,
                    //   backgroundImage: AssetImage('images/admain.jpg'),
                    // ),
                  ),
                ),
                Center(
                  child: Text(
                    'Student',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'FiraSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.white

                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldStyle(hint:'Email', icon:FontAwesomeIcons.envelope ,fieldHeight: 50.0 ,isBool: false,
                        onChanged: (value){
                          email = value ;
                        },),
                      SizedBox(
                        height: 50.0,
                      ),
                      TextFieldStyle(hint:'Password', icon:FontAwesomeIcons.key ,fieldHeight: 50.0,isBool: true,
                        onChanged: (value){
                          password = value ;
                        },),
                      SizedBox(
                        height: 50.0,
                      ),
                      RoundedLoginButton(onPressed: ()async {
                        if (email == null || email.isEmpty) {
                          displatTostMessage('Please Enter email', context);
                        }
                        else if (password == null || password.isEmpty) {
                          displatTostMessage('Please Enter password', context);
                        } else if (password.length < 6) {
                          displatTostMessage(
                              'Please Enter has 6 strength password', context);
                        } else if (!email.contains('@')) {
                          displatTostMessage(
                              'Please Enter valid Email', context);
                        } else {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                email: email, password: password);
                            if (userCredential != null) {
                              erroMessage('You have successfully created Account please Login!');
                              // Navigator.of(context,rootNavigator: true).pop();

                              Navigator.pop(context, MaterialPageRoute(
                                  builder: (context) => StudentLoginScreen()));
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          }
                          on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              displatTostMessage('The password provided is too weak',context);
                            } else if (e.code == 'email-already-in-use') {
                              // displatTostMessage('Wrong password provided for that user', context);
                              displatTostMessage(
                                  'The account already exists for that email',context);
                            }
                          }
                        }
                      })

                    ],
                  ),
                ),
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
