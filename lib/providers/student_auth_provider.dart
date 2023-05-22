import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/student_model.dart';
class StudentAuthProvider with ChangeNotifier{

  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  final db = FirebaseFirestore.instance.collection('StudentData')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  addStudentData({
    required String? studentEmail,
    required String? studentPassword,
    required String? role,
  })async{
    db.set({
      'adminEmail':studentEmail,
      'adminPassword':studentPassword,
      'role':role,
      'uid':uid,
    });
  }
StudentModel? studentCurrentModel ;
  getStudentData()async{
    StudentModel studentModel;
    var value = await db.get();
    if(value.exists){
      studentModel = StudentModel(
          studentEmail: value.get('adminEmail'),
          studentPassword: value.get('adminPassword'),
          role: value.get('role'),
          uid: value.get('uid')
      );
      studentCurrentModel = studentModel;
      notifyListeners();
    }
  }
  StudentModel? get currentStudent{
    return studentCurrentModel;
  }

}