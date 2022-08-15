import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/providers/received_amounts/received_amounts.dart';
import '../providers/user.dart' as userProvider;

class FirebaseFirestoreHelper {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  Future<void> updateReceivedAmount(
      Map<String, Object> json,
      String selectedCard,
      BuildContext context,
      String alreadyReceivedAmountId) async {
    final receivedAmount = Provider.of<ReceivedAmounts>(context, listen: false)
        .getByContractId(json['contract id'] as String);
    print(alreadyReceivedAmountId);
    print(receivedAmount!.id);
    // if (receivedAmount != null) {
    await _firestore
        .collection('forms')
        .doc(_user!.uid)
        .collection(selectedCard)
        .doc(alreadyReceivedAmountId)
        .update(json)
        .timeout(const Duration(seconds: 5), onTimeout: () {
      throw Exception('Slow internet connection, try again later');
    });
  }

  Future<DocumentReference<Map<String, dynamic>>> uploadFormData(
      Map<String, Object> json, String selectedCard) async {
    return await _firestore
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
