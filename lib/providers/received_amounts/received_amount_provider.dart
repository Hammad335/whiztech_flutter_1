import 'package:flutter/material.dart';
import 'package:whiztech_flutter_first_project/models/received_amount.dart';

class ReceivedAmountProvider with ChangeNotifier {
  String _contract = '';
  String _contractId = '';
  String _contractDate = '';
  double _contractAmount = 0.0;
  double _receiveAmount = 0.0;
  double _balanceAmount = 0.0;

  ReceivedAmount get getReceivedAmount {
    return ReceivedAmount(
      contract: _contract,
      contractId: _contractId,
      contractDate: _contractDate,
      contractAmount: _contractAmount,
      receiveAmount: _receiveAmount,
      balanceAmount: _balanceAmount,
    );
  }

  set contract(String value) {
    _contract = value;
  }

  set contractDate(String value) {
    _contractDate = value;
  }

  set contractAmount(double value) {
    _contractAmount = value;
  }

  set balanceAmount(double value) {
    _balanceAmount = value;
  }

  set receiveAmount(double value) {
    _receiveAmount = value;
  }

  set contractId(String value) {
    _contractId = value;
  }
}
