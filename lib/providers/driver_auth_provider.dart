import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/driver_model.dart';

class DriverAuthProvider with ChangeNotifier {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  final db = FirebaseFirestore.instance.collection('locations')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  addDriverAuthData(
      {
       required String? driverName,
       required String? driverPhoneNumber,
       required String? driverBussNumber,
       required String? driverEmail,
       required String? driverPassword,
       required String? role,
      }) async {
    db.set({
      'driverName': driverName,
      'driverEmail': driverEmail,
      'driverPhoneNumber':driverPhoneNumber,
      'driverBussNumber': driverBussNumber,
      'driverPassword': driverPassword,
      'role':role,
      'uid':uid,
    });
  }




  DriverModel? currentDriverData;

  //get driver data
  getDriverData() async {
    DriverModel driverModel;
    var value = await db.get();
    if(value.exists){
      driverModel = DriverModel(
          driverName: value.get('driverName'),
          driverPhoneNumber:value.get('driverPhoneNumber'),
          driverBussNumber: value.get('driverBussNumber'),
          driverEmail: value.get('driverEmail'),
          driverPassword: value.get('driverPassword'),
          uId: value.get('uid'),
          role: value.get('role'),
      );
      currentDriverData = driverModel;
      notifyListeners();
    }
  }
  DriverModel? get currentDriver{
    return currentDriverData;
  }



}