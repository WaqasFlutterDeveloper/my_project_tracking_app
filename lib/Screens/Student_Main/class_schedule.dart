import 'package:flutter/material.dart';

class ClasSchudle extends StatefulWidget {
  const ClasSchudle({Key? key}) : super(key: key);

  @override
  State<ClasSchudle> createState() => _ClasSchudleState();
}

class _ClasSchudleState extends State<ClasSchudle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Bus Schedule',style: TextStyle(fontSize: 30.0,color: Colors.black),)),

    );
  }
}
