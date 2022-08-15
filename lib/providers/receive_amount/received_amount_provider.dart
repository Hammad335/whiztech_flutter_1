import 'package:flutter/material.dart';

class ReceivedAmountProvider with ChangeNotifier {
  String _contract = '';
  String _contractDate = '';
  double _receiveAmount = 0.0;
  double _balanceAmount = 0.0;

  set contract(String value) {
    _contract = value;
  }

  set contractDate(String value) {
    _contractDate = value;
  }

  set balanceAmount(double value) {
    _balanceAmount = value;
  }

  set receiveAmount(double value) {
    _receiveAmount = value;
  }
}
