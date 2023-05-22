import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Screens/Home_Pages/driver_main.dart';
import '../models/user_Model.dart';
class AuthByEmail{
  String email = '';
  String password = '';
  signUp({
    required email ,
    required password
  })async{

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email, password: password);
    //  If signUp done then shift user to first page

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
  }

  Future<void> login(
      String? _email , String? _password
      )async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email!,
          password: _password!
      );
      // Navigator.pushNamed(context, '/signup');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }





  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  final db = FirebaseFirestore.instance.collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid);
  usersData({
     String? email,
     String? password,
     String? role,
  })async{
    db.set({
      'Email':email,
      'Password':password,
      'role':role,
      'uid':uid,
    });
  }
  final driver = FirebaseFirestore.instance.collection('locations')
      .doc(FirebaseAuth.instance.currentUser?.uid);
  driverData({
     String? name,
     String? phone,
     String? bussNo,
  })async{
    driver.set({
      'name':name,
      'phoneNo':phone,
      'bussNo':bussNo,
    });
  }

UsersModel? usersDATA;
  getUserData()async{
    UsersModel usersModel;
    var value = await db.get();
    if(value.exists){
      usersModel = UsersModel(
          email: value.get('Email'),
          password: value.get('Password'),
          role: value.get('role'),
          uid: value.get('uid')
      );
      usersDATA = usersModel;

    }
  }
  UsersModel? get currentUser{
    return usersDATA;
  }

}