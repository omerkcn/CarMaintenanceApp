import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  String? takingCurrentUserEmail() {
    return _firebaseAuth.currentUser?.email;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {

    try{
      return await FirebaseAuth.instance.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }

  Stream<User?> authStatus() {
    return _firebaseAuth.authStateChanges();
  }
}
