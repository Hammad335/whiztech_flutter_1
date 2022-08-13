import 'package:flutter/material.dart';

class ContractSignAmountDiscProvider with ChangeNotifier {
  double _amount = 0.0;
  double _taxVatPercentage = 0.0;
  double _taxVatAmount = 0.0;
  double _discountPercentage = 0.0;
  double _discountAmount = 0.0;
  TextEditingController taxVatPercentController = TextEditingController();
  TextEditingController taxVatAmountController = TextEditingController();
  TextEditingController discountPercentController = TextEditingController();
  TextEditingController discountAmountController = TextEditingController();

  void reset() {
    _amount = 0.0;
    _taxVatPercentage = 0.0;
    _taxVatAmount = 0.0;
    _discountPercentage = 0.0;
    _discountAmount = 0.0;
  }

  void dynamicallyChangePercentAmountValue(
    double amount,
    String fieldName,
  ) {}

  double get getTaxVatAmount {
    _taxVatPercentage = double.parse(taxVatPercentController.text);
    if (_taxVatPercentage == 0.0 || _amount == 0.0) return 0.0;
    return (_taxVatPercentage * _amount) / 100.0;
  }

  double get getTaxVatPercent {
    if (_taxVatAmount == 0.0 || _amount == 0.0) return 0.0;
    return (_taxVatAmount * 100.0) / _amount;
  }

  double get getDiscountPercent {
    if (_discountAmount == 0.0 || _amount == 0.0) return 0.0;
    return (_discountAmount * 100.0) / _amount;
  }

  double get getDiscountAmount {
    _discountPercentage = double.parse(discountPercentController.text);
    if (_discountPercentage == 0.0 || _amount == 0.0) return 0.0;
    return (_discountPercentage * _amount) / 100.0;
  }

  set setTaxVatAmountController(TextEditingController controller) {
    taxVatAmountController = controller;
  }

  set setTaxVatPercentController(TextEditingController controller) {
    taxVatPercentController = controller;
  }

  TextEditingController get getTaxVatAmountController {
    return taxVatAmountController;
  }

  TextEditingController get getTaxVatPercentController {
    return taxVatPercentController;
  }

  set setDiscountAmountController(TextEditingController controller) {
    discountAmountController = controller;
  }

  set setDiscountPercentController(TextEditingController controller) {
    discountPercentController = controller;
  }

  TextEditingController get getDiscountAmountController {
    return discountAmountController;
  }

  TextEditingController get getDiscountPercentController {
    return discountPercentController;
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

  bool get isTaxVatPercentZero {
    return _amount == 0.0 || _taxVatAmount == 0;
  }

  bool get isDiscountPercentZero {
    return _amount == 0.0 || _discountAmount == 0;
  }
}
