import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/admain_model.dart';

class AdminAuthProvider with ChangeNotifier{

  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  final db = FirebaseFirestore.instance.collection('AdminData')
      .doc(FirebaseAuth.instance.currentUser?.uid);
  addAdminData({
    required String? adminEmail,
    required String? adminPassword,
    required String? role,
   })async{
    db.set({
      'adminEmail':adminEmail,
      'adminPassword':adminPassword,
      'role':role,
      'uid':uid,
    });
}
AdminModel? currentAdminModel;

  getAdminData()async{
    AdminModel adminModel;
    var value = await db.get();
    if(value.exists){
      adminModel = AdminModel(
          adminEmail: value.get('adminEmail'),
          adminPassword: value.get('adminPassword'),
          role: value.get('role'),
          uid: value.get('uid')
      );
      currentAdminModel = adminModel;
      notifyListeners();
    }
  }
  AdminModel? get currentAdmin{
    return currentAdminModel;
  }

}