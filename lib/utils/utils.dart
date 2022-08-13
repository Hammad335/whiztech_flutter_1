import 'package:flutter/material.dart';
import '../constants/constants.dart';

class Utils {
  static String? userNameValidation(String? userName) {
    if (userName == null || userName.isEmpty) {
      return 'Please provide username';
    } else if (userName.length <= 2) {
      return 'Too short, can be b/w 2 to 7 characters';
    } else if (userName.length >= 7) {
      return 'Too long, can be b/w 2 to 7 characters';
    }
    return null;
  }

  static String? passwordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please provide password';
    } else if (password.length <= 5) {
      return 'Too short, type at least 6 character';
    }
    return null;
  }

  static String? emailValidation(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please provide email address';
    } else if (!email.endsWith('@gmail.com')) {
      return 'Badly formatted';
    }
    return null;
  }

  static void showSnackBar(BuildContext context, String message, int duration) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: duration),
      backgroundColor: kPrimaryColor.withOpacity(0.5),
    ));
  }

  static bool saveForm(GlobalKey<FormState> formKey) {
    final isValid = formKey.currentState
        ?.validate(); // calls onValidate method of each textFo
    if (!isValid!) return false;
    formKey.currentState?.save(); // calls onSaved method of each textFormField
    return true;
  }
}
