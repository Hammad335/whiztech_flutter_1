import 'package:flutter/material.dart';
import 'package:whiztech_flutter_first_project/models/client.dart';

class ClientProvider with ChangeNotifier {
  String _name = '';
  String _email = '';
  String _phone = '';
  String _address = '';

  Client get getClient {
    return Client(name: _name, phone: _phone, email: _email, address: _address);
  }

  ClientProvider _signNewContract(
      {required String name,
      required String email,
      required String phone,
      required String address}) {
    _name = name;
    _email = email;
    _phone = phone;
    _address = address;
    return this;
  }

  Map<String, Object> toJson() {
    return {
      'name': _name,
      'email': _email,
      'phone': _phone,
      'address': _address,
    };
  }

  set address(String value) {
    _address = value;
  }

  set phone(String value) {
    _phone = value;
  }

  set email(String value) {
    _email = value;
  }

  set name(String value) {
    _name = value;
  }
}
