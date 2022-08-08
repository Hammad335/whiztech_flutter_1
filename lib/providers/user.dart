import 'package:flutter/material.dart';

class User with ChangeNotifier {
  late String? userId;
  late String userName;
  late String email;

  void setUser(String? userId, String userName, String email) {
    this.userId = userId ?? this.userId;
    this.userName = userName;
    this.email = email;
  }

  void setUserId(String userId) {
    this.userId = userId;
  }

  User get getCurrentUser {
    return this;
  }
}
