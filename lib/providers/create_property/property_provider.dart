import 'package:flutter/material.dart';

class PropertyProvider with ChangeNotifier {
  String _name = '';
  String _size = '';
  String _propertyType = '';

  PropertyProvider get getProperty {
    return this;
  }

  PropertyProvider _signNewContract({
    required String name,
    required String size,
    required String propertyType,
  }) {
    _name = name;
    _size = size;
    _propertyType = propertyType;
    return this;
  }

  Map<String, Object> toJson() {
    return {
      'name': _name,
      'size': _size,
      'property type': _propertyType,
    };
  }

  static PropertyProvider? fromJson(Map<String, Object> jsonType) {
    return PropertyProvider()._signNewContract(
      name: jsonType['name'] as String,
      size: jsonType['size'] as String,
      propertyType: jsonType['property type'] as String,
    );
  }

  set propertyType(String value) {
    _propertyType = value;
  }

  set size(String value) {
    _size = value;
  }

  set name(String value) {
    _name = value;
  }
}