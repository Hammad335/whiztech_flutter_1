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

  bool get isTaxVatPercentZero {
    if (double.tryParse(taxVatAmountController.text) == null) return true;
    _taxVatAmount = double.parse(taxVatAmountController.text);
    return _amount == 0.0 || _taxVatAmount == 0;
  }

  bool get isDiscountPercentZero {
    if (double.tryParse(discountAmountController.text) == null) return true;
    _discountAmount = double.parse(discountAmountController.text);
    return _amount == 0.0 || _discountAmount == 0;
  }

  void onChanged(String fieldName, String amount_) {
    if (fieldName == 'amount') {
      if (amount_.isEmpty ||
          double.tryParse(amount_) != null && double.parse(amount_) == 0.0) {
        resetFields();
      } else if (amount_.isNotEmpty && double.tryParse(amount_) != null) {
        _amount = double.parse(amount_);
        if (!isTaxVatPercentZero) {
          taxVatAmountController.text = getTaxVatAmount.toStringAsFixed(1);
        }
        if (!isDiscountPercentZero) {
          discountAmountController.text = getDiscountAmount.toStringAsFixed(1);
        }
      }
    } else if (fieldName == 'tax_vat_%') {
      if (amount_.isNotEmpty && double.tryParse(amount_) != null) {
        _taxVatPercentage = double.parse(amount_);
        taxVatAmountController.text = getTaxVatAmount.toStringAsFixed(1);
      } else if (amount_.isEmpty || double.tryParse(amount_) == null) {
        taxVatAmountController.clear();
      }
    } else if (fieldName == 'tax_vat_amount') {
      if (amount_.isNotEmpty && double.tryParse(amount_) != null) {
        _taxVatAmount = double.parse(amount_);
        taxVatPercentController.text = getTaxVatPercent.toStringAsFixed(1);
      } else if (amount_.isEmpty || double.tryParse(amount_) == null) {
        taxVatPercentController.clear();
      }
    } else if (fieldName == 'discount_%') {
      if (amount_.isNotEmpty && double.tryParse(amount_) != null) {
        _discountPercentage = double.parse(amount_);
        discountAmountController.text = getDiscountAmount.toStringAsFixed(1);
      } else if (amount_.isEmpty || double.tryParse(amount_) == null) {
        discountAmountController.clear();
      }
    } else if (fieldName == 'discount_amount') {
      if (amount_.isNotEmpty && double.tryParse(amount_) != null) {
        _discountAmount = double.parse(amount_);
        discountPercentController.text = getDiscountPercent.toStringAsFixed(1);
      } else if (amount_.isEmpty || double.tryParse(amount_) == null) {
        discountPercentController.clear();
      }
    }
  }

  void resetFields() {
    reset();
    taxVatAmountController.clear();
    taxVatPercentController.clear();
    discountPercentController.clear();
    discountAmountController.clear();
  }

  void reset() {
    _amount = 0.0;
    _taxVatPercentage = 0.0;
    _taxVatAmount = 0.0;
    _discountPercentage = 0.0;
    _discountAmount = 0.0;
  }

  set setTaxVatAmountController(TextEditingController controller) {
    taxVatAmountController = controller;
  }

  set setTaxVatPercentController(TextEditingController controller) {
    taxVatPercentController = controller;
  }

  set setDiscountAmountController(TextEditingController controller) {
    discountAmountController = controller;
  }

  set setDiscountPercentController(TextEditingController controller) {
    discountPercentController = controller;
  }
}
