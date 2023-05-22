import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final CollectionReference _userCollection =
  _firestore.collection('user');

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //user class
  // late u.User user;

  Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = _auth.currentUser!;
    return currentUser;
  }

  Future<String> getUserDetails() async {
    User currentUser = await getCurrentUser();

    DocumentSnapshot documentSnapshot =
    await _userCollection.doc(currentUser.uid).get();

    Map<String, dynamic> data = documentSnapshot.data as Map<String, dynamic>;

    return data.toString();
  }
}