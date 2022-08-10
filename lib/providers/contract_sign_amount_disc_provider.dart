import 'package:flutter/material.dart';

class ContractSignAmountDiscProvider with ChangeNotifier {
  double _amount = 0.0;
  double _taxVatPercentage = 0.0;
  double _discountPercentage = 0.0;
  TextEditingController taxVatAmountController = TextEditingController();
  TextEditingController discountAmountController = TextEditingController();

  void reset() {
    _amount = 0.0;
    _taxVatPercentage = 0.0;
    _discountPercentage = 0.0;
  }

  double get getTaxVatAmount {
    return (_taxVatPercentage * _amount) / 100.0;
  }

  double get getDiscountAmount {
    return (_discountPercentage * _amount) / 100.0;
  }

  set setTaxVatAmountController(TextEditingController controller) {
    taxVatAmountController = controller;
  }

  TextEditingController get getTaxVatAmountController {
    return taxVatAmountController;
  }

  set setDiscountAmountController(TextEditingController controller) {
    discountAmountController = controller;
  }

  TextEditingController get getDiscountAmountController {
    return discountAmountController;
  }

  set amount(double value) {
    _amount = value;
    // print(_amount);
  }

  set taxVatPercentage(double value) {
    _taxVatPercentage = value;
    // print(_taxVatPercentage);
  }

  set discountPercentage(double value) {
    _discountPercentage = value;
  }
}
