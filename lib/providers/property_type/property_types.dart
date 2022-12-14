import 'package:flutter/material.dart';

import '../../models/property_type.dart';
import 'package:collection/collection.dart';

class PropertyTypes with ChangeNotifier {
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
    _propertyTypes.firstWhereOrNull((element) {
      if (element.name.trim().toLowerCase() == type.trim().toLowerCase()) {
        return doesExist = true;
      } else {
        return doesExist = false;
      }
    });
    return doesExist;
  }

  bool doesExistCaseSensitive(String type) {
    bool doesExist = false;
    _propertyTypes.firstWhereOrNull((element) {
      if (element.name.trim() == type.trim()) {
        return doesExist = true;
      } else {
        return doesExist = false;
      }
    });
    return doesExist;
  }
}
