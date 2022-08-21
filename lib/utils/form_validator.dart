import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/providers/create_property/properties.dart';

import '../providers/client_creation/clients.dart';
import '../providers/contract_sign/contracts.dart';
import '../providers/property_type/property_types.dart';

class FormValidator {
  static String? validateUserName(String? userName) {
    if (userName == null || userName.isEmpty) {
      return 'Please provide username';
    } else if (userName.length <= 2) {
      return 'Too short, can be b/w 2 to 7 characters';
    } else if (userName.length >= 7) {
      return 'Too long, can be b/w 2 to 7 characters';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please provide password';
    } else if (password.length <= 5) {
      return 'Too short, type at least 6 character';
    }
    return null;
  }

  static String? validateClientName(String? name, BuildContext context) {
    final clients = Provider.of<Clients>(context, listen: false);
    if (name == null || name.isEmpty) {
      return 'Please provide name';
    } else if (name.length >= 21) {
      return 'Too long';
    } else if (clients.doesExist(name)) {
      return 'Client already exists';
    }
    return null;
  }

  static String? validatePropertyName(String? name, BuildContext context) {
    final properties = Provider.of<Properties>(context, listen: false);
    if (name == null || name.isEmpty) {
      return 'Please provide name';
    } else if (name.length >= 21) {
      return 'Too long';
    } else if (properties.doesExist(name)) {
      return 'Property already exists';
    }
    return null;
  }

  static String? validatePropertyNameCaseSensitive(
      String? name, BuildContext context) {
    final properties = Provider.of<Properties>(context, listen: false);
    if (name == null || name.isEmpty) {
      return 'Please provide name';
    } else if (name.length >= 21) {
      return 'Too long';
    } else if (!properties.doesExistCaseSensitive(name)) {
      return 'Property does not exist';
    }
    return null;
  }

  static String? validateSize(String? size) {
    if (size == null || size.isEmpty) {
      return 'Please provide size';
    }
    return null;
  }

  static String? validateLocation(String? location) {
    if (location == null || location.isEmpty) {
      return 'Please provide location';
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Please provide phone';
    } else if (phone.length < 11 || phone.length > 11) {
      return 'Invalid Number, e.g. +92...';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please provide email address';
    } else if (!email.endsWith('@gmail.com')) {
      return 'Badly formatted';
    }
    return null;
  }

  static String? validateAddress(String? address) {
    if (address == null || address.isEmpty) {
      return 'Please provide address';
    }
    return null;
  }

  static String? validateContractClientCaseSensitive(
      String? client, BuildContext context) {
    final provider = Provider.of<Contracts>(context, listen: false);
    if (client == null || client.isEmpty) {
      return 'Please select any contract';
    }
    if (!provider.doesExistCaseSensitive(client)) {
      return 'client does not exist';
    }
    return null;
  }

  static String? validatePropertyType(
      String? propertyType, BuildContext context) {
    final provider = Provider.of<PropertyTypes>(context, listen: false);
    if (propertyType == null || propertyType.isEmpty) {
      return 'Please select property type';
    }
    if (provider.doesExist(propertyType)) {
      return 'Property type already exist';
    }
    return null;
  }

  static String? validatePropertyTypeCaseSensitive(
      String? propertyType, BuildContext context) {
    final provider = Provider.of<PropertyTypes>(context, listen: false);
    if (propertyType == null || propertyType.isEmpty) {
      return 'Please select property type';
    }
    if (!provider.doesExistCaseSensitive(propertyType)) {
      return 'Property type does not exist';
    }
    return null;
  }

  static String? doNotValidate(String? data) {
    return null;
  }

  static String? validateAmount(String? amount) {
    if (amount == null || amount.isEmpty) {
      return 'Please enter amount';
    } else if (double.tryParse(amount) == null) {
      return 'Enter valid amount';
    }
    return null;
  }
}
