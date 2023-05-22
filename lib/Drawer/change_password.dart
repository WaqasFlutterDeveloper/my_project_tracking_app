import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iub_transport_system/Drawer/contact_us.dart';

import '../Screens/Home_Pages/driver_main.dart';
import '../Screens/Login_Screen/driver_login_screen.dart';
import '../Screens/Login_Screen/student_login_screen.dart';
import '../const.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override

  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  String? newPassword;
  final currentUser = FirebaseAuth.instance.currentUser;
  void changedPassword() async{
    try{
      await currentUser?.updatePassword(newPassword!);
      FirebaseAuth.instance.signOut();
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('You have Changed Password ..Again Log In',style: TextStyle(fontSize: 25.0),)));
      // Navigator.pop(context, MaterialPageRoute(
      //     builder: (context) => DriverLoginScreen()));
    }catch (e){
      print(e);
    }
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have Changed Password ..Again Log In',style: TextStyle(fontSize: 25.0),)));
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => StudentLoginScreen()));

  }

  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kBColour,
      appBar: AppBar(
         backgroundColor: kAppBarColour,
        title: Text('Change Password'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.password,
                        size: 30.0,
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'New Password',
                      labelStyle: TextStyle(fontSize: 20.0),
                      hintText: 'Enter new password',
                      errorStyle: TextStyle(fontSize: 20.0, color: Colors.red)),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        setState((){
                          newPassword = passwordController.text;
                        });
                        changedPassword();
                      }
                    },
                    child: Text(
                      'Change Password',
                      style: TextStyle(fontSize: 20.0,),
                    )),
              ),
              SizedBox(height: 15.0,),

            ],
          ),
        ),
      ),
    );
  }
}
