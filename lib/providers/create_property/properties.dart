import 'package:flutter/material.dart';
import 'package:whiztech_flutter_first_project/models/property.dart';

class Properties with ChangeNotifier {
  List<Property> _properties = [];

  void addProperty(Property property) {
    _properties.add(property);
  }

  set populateProperties(List<Property> properties) {
    _properties = properties;
  }

  List<String> getProperties(String pattern) {
    List<String> types = [];
    for (var type in _properties) {
      if (type.name.toLowerCase().contains(pattern.toLowerCase())) {
        types.add(type.name);
      }
    }
    return types;
  }

  bool doesExist(String property) {
    bool doesExist = false;
    try {
      _properties.firstWhere((element) {
        if (element.name.toLowerCase() == property.toLowerCase()) {
          return doesExist = true;
        } else {
          return doesExist = false;
        }
      });
    } catch (e) {
      doesExist = false;
    }
    return doesExist;
  }
}