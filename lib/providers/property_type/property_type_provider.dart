import 'package:flutter/material.dart';
import 'package:whiztech_flutter_first_project/models/property.dart';

import '../../models/property_type.dart';

class PropertyTypeProvider with ChangeNotifier {
  String _name = '';
  String _location = '';

  PropertyType get getPropertyType {
    return PropertyType(
      name: _name,
      location: _location,
    );
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

  static PropertyType fromJson(Map<String, Object> jsonProperty) {
    return PropertyType(
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
