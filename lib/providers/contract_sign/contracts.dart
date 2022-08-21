import 'package:flutter/material.dart';
import '../../models/contract.dart';
import 'package:collection/collection.dart';

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

  Contract getSingleContractById(String id) {
    return _contracts.firstWhere((element) => element.id == id);
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
        contracts.add('${contract.clientSelection}:${contract.id}');
      }
    }
    return contracts;
  }

  List<String> getDistinctContractClients(String pattern) {
    Set<String> contracts = {};
    for (Contract contract in _contracts) {
      if (contract.clientSelection
          .toLowerCase()
          .contains(pattern.toLowerCase())) {
        contracts.add(contract.clientSelection);
      }
    }
    return contracts.toList();
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
    _contracts.firstWhereOrNull((element) {
      if (element.clientSelection.trim().toLowerCase() ==
          client.trim().toLowerCase()) {
        return doesExist = true;
      } else {
        return doesExist = false;
      }
    });
    return doesExist;
  }

  bool doesExistCaseSensitive(String client) {
    bool doesExist = false;
    _contracts.firstWhereOrNull((element) {
      if (element.clientSelection.trim() == client.trim()) {
        return doesExist = true;
      } else {
        return doesExist = false;
      }
    });
    return doesExist;
  }
}
