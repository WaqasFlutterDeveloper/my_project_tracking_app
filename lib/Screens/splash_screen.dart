import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../const.dart';
import 'Admain_Main/admin_dashbord.dart';
import 'Home_Pages/admain_main.dart';
import 'Home_Pages/driver_main.dart';
import 'Home_Pages/studen_main.dart';
import 'Home_Pages/student_mainPage.dart';
import 'Login_Screen/admin_login_screen.dart';
import 'Login_Screen/driver_login_screen.dart';
import 'Login_Screen/student_login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
   final user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    Timer(const Duration(seconds: 2),
          () {
            // FirebaseAuth.instance.currentUser == null ?
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DriverLoginScreen()))
            //     :  Navigator.push(context, MaterialPageRoute(
            //     builder: (context) => DriverPage()));

            FirebaseAuth.instance.currentUser == null ?
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentLoginScreen()))
                :  Navigator.push(context, MaterialPageRoute(
                builder: (context) => StudentHomeScreen()));

            // FirebaseAuth.instance.currentUser == null ?
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DriverLoginScreen()))
            //     :  Navigator.push(context, MaterialPageRoute(
            //     builder: (context) => AdminPage()));

    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBarColour,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          Container(
            width: 300,
            child: Image(image: AssetImage('images/logo.png'),),
          ),

          // AnimatedBuilder(
          //   // animation: _controller,
          //   child: Container(
          //     width: 200.0,
          //     height: 200.0,
          //     child: const Center(
          //       child: Image(image: AssetImage('images/virus.png')),
          //     ),
          //   ),
          //   builder: (BuildContext context, Widget? child) {
          //     return Transform.rotate(
          //       angle: _controller.value * 2.0 * math.pi,
          //       child: child,
          //     );
          //   },
          // ),

          SizedBox(height: MediaQuery.of(context).size.height * .08,),
          const Align(
            alignment: Alignment.center,
            child: Text('Bus Tracking App\n',textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25,
                  color: Colors.white,
                  fontFamily: 'FiraSans',
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
