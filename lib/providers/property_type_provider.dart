import 'package:flutter/material.dart';

import '../models/property_type.dart';

class PropertyTypeProvider with ChangeNotifier {
  List<PropertyType> _propertyTypes = [];

  void addPropertyType(PropertyType propertyType) {
    _propertyTypes.add(propertyType);
  }

  set populatePropertyTypes(List<PropertyType> propertyTypes) {
    _propertyTypes = propertyTypes;
  }

  List<String> getPropertyTypes(String pattern) {
    List<String> types = [];
    for (var type in _propertyTypes) {
      if (type.name.toLowerCase().contains(pattern.toLowerCase())) {
        types.add(type.name);
      }
    }
    return types;
  }

  bool doesExist(String type) {
    bool doesExist = false;
    try {
      _propertyTypes.firstWhere((element) {
        if (element.name.toLowerCase() == type.toLowerCase()) {
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
