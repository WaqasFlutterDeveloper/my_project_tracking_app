import 'package:flutter/material.dart';

class TextFieldStyle extends StatelessWidget {

  TextFieldStyle({required this.icon ,required this.fieldHeight ,
    required this.hint , required this.onChanged ,required this.isBool});

  IconData? icon;
  String? hint;
  double? fieldHeight;
  bool isBool;
  final Function(String val) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fieldHeight!,
      // width:150.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0)),
      child: Center(
        child: TextField(
          onChanged: (String value){
            onChanged(value);
          },obscureText: isBool,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(
                  // ,
                  icon!,
                  size: 30.0,
                  color: Colors.green,
                )),
            hintText: hint!,
            hintStyle: TextStyle(
                fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }
}