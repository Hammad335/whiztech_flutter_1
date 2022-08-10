import 'package:flutter/material.dart';
import 'package:whiztech_flutter_first_project/models/property.dart';

class PropertyTypeProvider with ChangeNotifier {
  String _name = '';
  String _location = '';

  PropertyTypeProvider get getPropertyType {
    return this;
  }

  PropertyTypeProvider _signNewContract({
    required String name,
    required String location,
  }) {
    _name = name;
    _location = location;
    return this;
  }

  Map<String, Object> toJson() {
    return {
      'name': _name,
      'location': _location,
    };
  }

  static PropertyTypeProvider fromJson(Map<String, Object> jsonProperty) {
    return PropertyTypeProvider()._signNewContract(
      name: jsonProperty['name'] as String,
      location: jsonProperty['location'] as String,
    );
  }

  set location(String value) {
    _location = value;
  }

  set name(String value) {
    _name = value;
  }
}
