import 'package:flutter/material.dart';

import '../../models/contract.dart';

class ContractSignProvider with ChangeNotifier {
  String _clientSelection = '';
  String _propertySelection = '';
  String _contractStartDate = '';
  String _contractEndDate = '';
  double _amount = 0.0;
  double _taxVatPercentage = 0.0;
  double _taxVatAmount = 0.0;
  double _discountPercentage = 0.0;
  double _discountAmount = 0.0;
  double _netAmount = 0.0;

  Contract get getContract {
    return Contract(
      clientSelection: _clientSelection,
      propertySelection: _propertySelection,
      contractStartDate: _contractStartDate,
      contractEndDate: _contractEndDate,
      amount: _amount,
      taxVatPercentage: _taxVatPercentage,
      taxVatAmount: _taxVatAmount,
      discountPercentage: _discountPercentage,
      discountAmount: _discountAmount,
      netAmount: _netAmount,
    );
  }

  set clientSelection(String value) {
    _clientSelection = value;
  }

  set propertySelection(String value) {
    _propertySelection = value;
  }

  set contractStartDate(String value) {
    _contractStartDate = value;
  }

  set contractEndDate(String value) {
    _contractEndDate = value;
  }

  set amount(double value) {
    _amount = value;
  }

  set taxVatPercentage(double value) {
    _taxVatPercentage = value;
  }

  set taxVatAmount(double value) {
    _taxVatAmount = value;
  }

  set discountPercentage(double value) {
    _discountPercentage = value;
  }

  set discountAmount(double value) {
    _discountAmount = value;
  }

  void setNetAmount() {
    _netAmount = _amount - _taxVatAmount - _discountAmount;
  }
}
