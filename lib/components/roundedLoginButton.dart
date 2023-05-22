import 'package:flutter/material.dart';

class RoundedLoginButton extends StatelessWidget {
  RoundedLoginButton({ required this.onPressed});
  Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        elevation: 5.0,
        color:Colors.white60,
        borderRadius: BorderRadius.circular(20.0),
        child: MaterialButton(
          onPressed: () {
            onPressed!();
          },
          // ()=>print(onPressed),
          minWidth: 350.0,
          height: 50.0,
          child: Text(
            'Login',
            style: TextStyle(
                fontFamily: 'FiraSans',
                fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}