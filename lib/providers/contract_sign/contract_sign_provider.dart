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
    );
  }

  ContractSignProvider _signNewContract({
    required String clientSelection,
    required String propertySelection,
    required String contractStartDate,
    required String contractEndDate,
    required double amount,
    required double taxVatPercentage,
    required double taxVatAmount,
    required double discountPercentage,
    required double discountAmount,
  }) {
    _clientSelection = clientSelection;
    _propertySelection = propertySelection;
    _contractStartDate = contractStartDate;
    _contractEndDate = contractEndDate;
    _amount = amount;
    _taxVatPercentage = taxVatPercentage;
    _taxVatAmount = taxVatAmount;
    _discountPercentage = discountPercentage;
    _discountAmount = discountAmount;
    return this;
  }

  Map<String, Object> toJson() {
    return {
      'client selection': _clientSelection,
      'property selection': _propertySelection,
      'contract start date': _contractStartDate,
      'contract end date': _contractEndDate,
      'amount': _amount,
      'tax/vat percentage': _taxVatPercentage,
      'tax/vat amount': _taxVatAmount,
      'discount percentage': _discountPercentage,
      'discount amount': _discountAmount,
    };
  }

  static ContractSignProvider? fromJson(Map<String, Object> jsonContract) {
    return ContractSignProvider()._signNewContract(
      clientSelection: jsonContract['client selection'] as String,
      propertySelection: jsonContract['property selection'] as String,
      contractStartDate: jsonContract['contract start date'] as String,
      contractEndDate: jsonContract['contract end date'] as String,
      amount: jsonContract['amount'] as double,
      taxVatPercentage: jsonContract['tax/vat percentage'] as double,
      taxVatAmount: jsonContract['tax/vat amount'] as double,
      discountPercentage: jsonContract['discount percentage'] as double,
      discountAmount: jsonContract['discount amount'] as double,
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
}
