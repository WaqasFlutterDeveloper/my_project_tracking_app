import 'package:flutter/material.dart';

import '../const.dart';
class Help extends StatefulWidget {
  static const String routeName = '/help';
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kAppBarColour,
        appBar: AppBar(
          backgroundColor: kBColour,
          title: Text("Sechdule Screen"),
        ),
        body: Center(child: Text("Now Development is Remaining")));
  }
}


class Routes {
  static const String help = Help.routeName;
}