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

  void addContract(Contract contract, String id) {
    final json = contract.toJson()..putIfAbsent('id', () => id);
    _contracts.add(Contract.fromJson(json));
  }

  Contract getSingleContract(String pattern) {
    return _contracts
        .firstWhere((element) => element.clientSelection == pattern);
  }

  String? getContractIdByName(String pattern) {
    return _contracts
        .firstWhere((element) => element.clientSelection == pattern)
        .id;
  }

  List<String> getContractClients(String pattern) {
    List<String> contracts = [];
    for (var contract in _contracts) {
      if (contract.clientSelection
          .toLowerCase()
          .contains(pattern.toLowerCase())) {
        contracts.add(contract.clientSelection);
      }
    }
    return contracts;
  }

  List<Contract> getContracts(String pattern) {
    List<Contract> contracts = [];
    for (var contract in _contracts) {
      if (contract.clientSelection
          .toLowerCase()
          .contains(pattern.toLowerCase())) {
        contracts.add(contract);
      }
    }
    return contracts;
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
