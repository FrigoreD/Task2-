import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('users');
  final firebaseInstance = FirebaseFirestore.instance;

  Future<String?> createUser(
      {required String uid,
      required String email,
      required String password}) async {
    await _firestore.doc(uid).set({
      'email': email,
      'password': password,
    });
  }

  Future<String?> getUserProfileData(String? uid) async {
    try {
      var response =
          await firebaseInstance.collection('users').doc(uid).get();
      return response['password'];
    } catch (e) {
      print(e);
    }
  }
}
