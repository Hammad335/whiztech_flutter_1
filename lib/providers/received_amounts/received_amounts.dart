import 'package:flutter/material.dart';
import 'package:whiztech_flutter_first_project/models/received_amount.dart';
import 'package:collection/collection.dart';

class ReceivedAmounts with ChangeNotifier {
  List<ReceivedAmount> _receivedAmounts = [];

  void addReceivedAmount(ReceivedAmount receivedAmount, String id) {
    final json = receivedAmount.toJson()..putIfAbsent('id', () => id);
    _receivedAmounts.add(ReceivedAmount.fromJson(json));
  }

  void updateReceivedAmount(ReceivedAmount receivedAmount) {
    _receivedAmounts
        .firstWhere(
            (element) => element.contractId == receivedAmount.contractId)
        .receiveAmount = receivedAmount.receiveAmount;
  }

  set populateReceivedAmounts(List<ReceivedAmount> receivedAmounts) {
    _receivedAmounts = receivedAmounts;
  }

  ReceivedAmount? getByContractId(String contractId) {
    return _receivedAmounts
        .firstWhereOrNull((element) => element.contractId == contractId);
  }

  // List<String> getPropertyTypes(String pattern) {
  //   List<String> types = [];
  //   for (var type in _propertyTypes) {
  //     if (type.name.toLowerCase().contains(pattern.toLowerCase())) {
  //       types.add(type.name);
  //     }
  //   }
  //   return types;
  // }

  // bool doesExist(String type) {
  //   bool doesExist = false;
  //   try {
  //     _propertyTypes.firstWhere((element) {
  //       if (element.name.toLowerCase() == type.toLowerCase()) {
  //         return doesExist = true;
  //       } else {
  //         return doesExist = false;
  //       }
  //     });
  //   } catch (e) {
  //     doesExist = false;
  //   }
  //   return doesExist;
  // }
}
