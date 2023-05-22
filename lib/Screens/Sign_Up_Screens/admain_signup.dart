import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../auth/authentication.dart';
import '../../components/roundedLoginButton.dart';
import '../../components/textFieldDesign.dart';
import '../../const.dart';
import '../../providers/admain_auth_provider.dart';
import '../Home_Pages/admain_main.dart';

class AdminSignUp extends StatefulWidget {
  String role;
  AdminSignUp({required this.role});

  @override
  State<AdminSignUp> createState() => _AdminSignUpState();
}

class _AdminSignUpState extends State<AdminSignUp> {
  AdminAuthProvider adminAuthProvider = AdminAuthProvider();
  AuthByEmail authByEmail = AuthByEmail();
  bool showSpinner=false;
  String email='';
  String password='';
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall:showSpinner,
      child: Scaffold(
        backgroundColor: kAppBarColour,
        body: ListView(
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
                    'Admin',
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
                        print(email);
                      },),
                      SizedBox(
                        height: 50.0,
                      ),
                      TextFieldStyle(hint:'Password', icon:FontAwesomeIcons.key ,fieldHeight: 50.0,isBool: true,
                        onChanged: (value){
                         password =value ;
                        print(password);
                      },),
                      SizedBox(
                        height: 50.0,
                      ),
                      RoundedLoginButton(onPressed: ()async{

                        // adminAuthProvider.addAdminData(
                        //     adminEmail: email,
                        //     adminPassword: password,
                        //     role: widget.role,
                        // );

                        try {
                          setState(() {
                            showSpinner = true;
                          });
                          UserCredential userCredential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                              email: email, password: password);
                          //  If signUp done then shift user to first page
                          authByEmail.signUp(email: email, password: password);
                          if (userCredential != null) {
                            erroMessage('You have successfully created Account please Login!');
                            Navigator.pop(context, MaterialPageRoute(
                                builder: (context) => AdminPage()));
                          }
                          setState(() {
                            showSpinner = false;
                          });

                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        }

                      },)

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
