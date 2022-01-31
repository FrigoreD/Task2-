import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:task2/domain/user.dart';
import 'package:task2/infrastructation/database.dart';
import 'package:task2/infrastructation/failure/sign_in_failure.dart';
import 'package:task2/infrastructation/stack.dart';

import 'failure/sign_up_failure.dart';



class LogOutFailure implements Exception {}
class AuthRepository {
  
  final userInStack = Stack<DataUser>();
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthRepository({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  Stream<DataUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? DataUser.empty : firebaseUser.toUser;
      userInStack.push(user);
      return user;
    });
  }

  DataUser get currentUser {
    if (userInStack.isEmpty) {
      return DataUser.empty;
    } else {
      return userInStack.peek;
    }
  }


  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
          Database().createUser(password: password, email: email, uid: currentUser.uid.toString() );
    } on firebase_auth.FirebaseAuthException catch (e) {
      SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logOut() async {
    try {
      userInStack.pop();
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  DataUser get toUser {
    return DataUser(uid: uid, email: email);
  }
}
