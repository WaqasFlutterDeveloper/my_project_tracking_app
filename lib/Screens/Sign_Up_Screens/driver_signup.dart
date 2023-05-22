import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../auth/authentication.dart';
import '../../components/roundedLoginButton.dart';
import '../../components/textFieldDesign.dart';
import '../../const.dart';
import '../../providers/driver_auth_provider.dart';
import '../Login_Screen/driver_login_screen.dart';


class DriverSignUp extends StatefulWidget {
  String role;
  DriverSignUp({required this.role});

  @override
  State<DriverSignUp> createState() => _DriverSignUpState();
}

class _DriverSignUpState extends State<DriverSignUp> {
  DriverAuthProvider driverAuthProvider = DriverAuthProvider();
  AuthByEmail authByEmail = AuthByEmail();
  bool showSpinner=false;
  String email='';
  String password='';
  String name='';
  String busNumber='';
  String phoneNumber='';
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
                  padding: EdgeInsets.fromLTRB(38.0, 30.0, 38.0, 15.0),
                  child: Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('images/drr.png'),
                        )),
                  ),
                ),
                Center(
                  child: Text(
                    'Driver',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'FiraSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.white

                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldStyle(hint:'Name', icon:FontAwesomeIcons.person ,fieldHeight: 50.0,isBool: false,
                        onChanged: (value){
                          name = value ;
                      },),
                      SizedBox(height: 20.0,),
                      TextFieldStyle(hint:'Phone No.', icon:FontAwesomeIcons.phone ,fieldHeight: 50.0,isBool: false,
                        onChanged: (value){
                        phoneNumber = value ;
                        },),
                      SizedBox(height: 20.0,),
                      TextFieldStyle(hint:'Bus No.', icon:FontAwesomeIcons.bus ,fieldHeight: 50.0,isBool: false,
                        onChanged: (value){
                          busNumber = value ;
                        },),
                      SizedBox(height: 20.0,),
                      TextFieldStyle(hint:'Email', icon:FontAwesomeIcons.envelope ,fieldHeight: 50.0,isBool: false,
                        onChanged: (value){
                          email = value ;
                        },),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFieldStyle(hint:'Password', icon:FontAwesomeIcons.key ,fieldHeight: 50.0,isBool: true,
                        onChanged: (value){
                          password = value ;
                        },),
                      SizedBox(
                        height: 25.0,
                      ),
                      RoundedLoginButton(onPressed: ()async{
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
                          authByEmail.driverData(phone: phoneNumber,name: name,bussNo: busNumber);
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                email: email, password: password);
                            if (userCredential != null) {
                              erroMessage('You have successfully created Account please Login!');
                              Navigator.pop(context, MaterialPageRoute(
                                  builder: (context) => DriverLoginScreen()));
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




