import 'package:flutter/material.dart';
import '../../GoogleMap_Location/student_map_view.dart';
import '../../Services/Notification/appTerminate_notification.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  @override
  void initState() {
    LocalNotificationService.subscribeStudents();
    super.initState();
  }
  Widget build(BuildContext context) {
    return  StudentMapViewPage();
  }
}
