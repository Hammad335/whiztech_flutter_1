import 'package:flutter/material.dart';

import '../../models/contract.dart';

class Contracts with ChangeNotifier {
  List<Contract> _contracts = [];

  List<Contract> get getAllContracts {
    return [..._contracts];
  }

  set populateContracts(List<Contract> contracts) {
    _contracts = contracts;
  }

  void addContract(Contract contract) {
    _contracts.add(contract);
  }

  Contract getSingleContract(String pattern) {
    return _contracts
        .firstWhere((element) => element.clientSelection == pattern);
  }

  List<String> getContracts(String pattern) {
    List<String> types = [];
    for (var contract in _contracts) {
      if (contract.clientSelection
          .toLowerCase()
          .contains(pattern.toLowerCase())) {
        types.add(contract.clientSelection);
      }
    }
    return types;
  }

  bool doesExist(String client) {
    bool doesExist = false;
    try {
      _contracts.firstWhere((element) {
        if (element.clientSelection.toLowerCase() == client.toLowerCase()) {
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
