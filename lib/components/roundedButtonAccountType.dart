import 'package:flutter/material.dart';

class RoundedButtonAccountType extends StatelessWidget {
  RoundedButtonAccountType({required this.title , required this.onPressed });
  String? title;
  Function? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 15.0),
      child:  Material(
        elevation: 5.0,
        // color: Colors.lightBlueAccent,
        color: Colors.white60,
        borderRadius: BorderRadius.circular(10.0),
        child: MaterialButton(
          onPressed: () {
            onPressed!();
          },
          minWidth: 200.0,
          height: 55.0,
          child: Text(
            title!,
            style: TextStyle(
                fontFamily: 'FiraSans',
                fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
