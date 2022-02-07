import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'failure/database_faliure.dart';

class Database {
  final FirebaseFirestore _firebaseFirestore;

  Database({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> registration(
      {required String email, required String password}) async {
    final uid = FirebaseAuth.instance.currentUser!.uid.toString();
    await _firebaseFirestore.collection('users').doc(uid).set({
      'email': email,
      'password': password,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    final uid = FirebaseAuth.instance.currentUser!.uid.toString();
    try {
      return _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('data')
          .snapshots();
    } on FirebaseException catch (e) {
      throw DatabaseFaliure.fromCode(e.code);
    } catch (_) {
      throw const DatabaseFaliure();
    }
  }

  Future<void> addNewUser(
      {required String username,
      required String surname,
      required String name,
      required String phone}) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid.toString();
      await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('data')
          .doc(username)
          .set({
        'username': username,
        'surname': surname,
        'name': name,
        'phone': phone
      });
    } on FirebaseException catch (e) {
      throw DatabaseFaliure.fromCode(e.code);
    } catch (_) {
      throw const DatabaseFaliure();
    }
  }

  Future<Map<String, dynamic>> getData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid.toString();
    QuerySnapshot<Map<String, dynamic>> data = await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('data')
        .get();
    return data.docs[0].data();
  }

  Future<void> deleteUser(String username) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid.toString();
      await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('data')
          .doc(username)
          .delete();
    } on FirebaseException catch (e) {
      throw DatabaseFaliure.fromCode(e.code);
    } catch (_) {
      throw const DatabaseFaliure();
    }
  }

  Future<void> editUser(String username) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid.toString();
      await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('data')
          .doc(username)
          .get();
    } on FirebaseException catch (e) {
      throw DatabaseFaliure.fromCode(e.code);
    } catch (_) {
      throw const DatabaseFaliure();
    }
  }
}
