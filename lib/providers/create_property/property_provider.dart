import 'package:flutter/material.dart';
import 'package:whiztech_flutter_first_project/models/property.dart';

class PropertyProvider with ChangeNotifier {
  String _name = '';
  String _size = '';
  String _propertyType = '';

  Property get getProperty {
    return Property(name: _name, size: _size, propertyType: _propertyType);
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
