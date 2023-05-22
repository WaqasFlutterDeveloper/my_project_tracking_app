
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:iub_transport_system/providers/admain_auth_provider.dart';
import 'package:iub_transport_system/providers/driver_auth_provider.dart';
import 'package:iub_transport_system/providers/student_auth_provider.dart';
import 'package:provider/provider.dart';

import 'GoogleMap_Location/student_map_view.dart';
import 'Screens/Home_Pages/admain_main.dart';
import 'Screens/Home_Pages/driver_main.dart';
import 'Screens/Home_Pages/student_mainPage.dart';
import 'Screens/splash_screen.dart';
import 'Services/NOTI/Rmain.dart';
import 'Services/Notification/appTerminate_notification.dart';
import 'Services/Notification/send_notification_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // subscribe to a topic.
  const topic = 'students';
  await FirebaseMessaging.instance.subscribeToTopic(topic);
  await FirebaseMessaging.instance.subscribeToTopic('all');
  await FirebaseMessaging.instance.unsubscribeFromTopic('admin');
  LocalNotificationService.subscribeStudents();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  LocalNotificationService.initialize();
  runApp( MyApp());
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}
class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider<DriverAuthProvider>(
            create: (context) => DriverAuthProvider()
        ),
        ChangeNotifierProvider<AdminAuthProvider>(
            create: (context) => AdminAuthProvider()
        ),
        ChangeNotifierProvider<StudentAuthProvider>(
            create: (context) => StudentAuthProvider()
        ),
      ],
      child:MaterialApp(
        title: 'Bus Tracking System',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        // home: AdminPage(),
        // home: DriverPage(),
        // home: MyHomePage(),
        // home: StudentHomeScreen(),
      ),
    );
  }
}


// flutter build apk -v --no-tree-shake-icons