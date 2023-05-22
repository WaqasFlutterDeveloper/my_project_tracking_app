import 'package:flutter/material.dart';

import '../../const.dart';

Widget createHeader() {
  return DrawerHeader(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // ClipRRect(
        //     borderRadius: BorderRadius.circular(50.0),
        //     child: Image.asset('images/drr.png',height: 100.0, width: 100,fit: BoxFit.cover,)),
        Text(
          'Settings',
          style: TextStyle(fontSize: 30.0, ),
        ),
      ],
    ),
    decoration: BoxDecoration(color: kAppBarColour),
  );
}



Widget createDrawerItem(
    {required  IconData icon,required String text,required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: (){
      onTap();
    },
  );
}



Widget createDriverDrawerItem(
    {required  IconData icon,required String text,required GestureTapCallback onTap, required Color colour}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon,color: colour,),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: (){
      onTap();
    },
  );
}
