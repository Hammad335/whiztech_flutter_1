import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart' as userProvider;

class FirebaseFirestoreHelper {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  Future<void> uploadFormData(
      Map<String, Object> json, String selectedCard) async {
    await _firestore
        .collection('forms')
        .doc(_user!.uid)
        .collection(selectedCard)
        .add(json)
        .timeout(const Duration(seconds: 5), onTimeout: () {
      throw Exception('Slow internet connection, try again later');
    });
  }

  Future<void> loginUser(String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .timeout(const Duration(seconds: 5), onTimeout: () {
      throw Exception('Slow internet connection, try again later');
    });
  }

  Future<UserCredential> registerUser(
      String userName, String email, String password) async {
    final response = await _auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .timeout(const Duration(seconds: 5), onTimeout: () {
      throw Exception('Slow internet connection, try again later');
    });

    // add user data to firestore
    await _firestore.collection('users').doc(response.user!.uid).set({
      'userName': userName,
      'email': password,
    });
    return response;
  }

  void setUserId(BuildContext context, UserCredential response) {
    Provider.of<userProvider.User>(context, listen: false)
        .setUserId(response.user!.uid);
  }
}
