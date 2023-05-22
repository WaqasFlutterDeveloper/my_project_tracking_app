
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../const.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  String email = '';
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  void forgetPassword()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if(email != null){
        print(email);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sent Mail for Reset Password',style: TextStyle(fontSize: 25.0),)));
      }
    }on FirebaseAuthException catch (e){
      print(e);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found for that email',style: TextStyle(fontSize: 25.0),)));}
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kAppBarColour,
        title: Text(
          'Forget Password',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            size: 30.0,
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 20.0),
                          hintText: 'Enter Email',
                          errorStyle: TextStyle(fontSize: 20.0, color: Colors.red)),
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        } else if (!value.contains('@')) {
                          return 'Not vaild Email';
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
                              email = emailController.text;
                            });
                            forgetPassword();
                          }
                        },
                        child: Text(
                          'Send  Email',
                          style: TextStyle(fontSize: 20.0,),
                        )),
                  ),
                  SizedBox(height: 15.0,),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
