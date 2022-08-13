import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../providers/contract_sign_amount_disc_provider.dart';

class AmountTextFormField extends StatefulWidget {
  final FocusNode amountFocusNode;
  Function amountCallBack;
  String? append;
  bool? readOnly;
  String fieldName;

  AmountTextFormField({
    this.append,
    required this.amountFocusNode,
    required this.amountCallBack,
    required this.fieldName,
    this.readOnly,
  });

  @override
  State<AmountTextFormField> createState() => _AmountTextFormFieldState();
}

class _AmountTextFormFieldState extends State<AmountTextFormField> {
  late TextEditingController _controller;
  late ContractSignAmountDiscProvider _amountDiscProvider;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _amountDiscProvider =
        Provider.of<ContractSignAmountDiscProvider>(context, listen: false);
    if (!(widget.fieldName == 'amount')) {
      if (widget.fieldName == 'tax_vat_%') {
        _amountDiscProvider.setTaxVatPercentController = _controller;
      } else if (widget.fieldName == 'tax_vat_amount') {
        _amountDiscProvider.setTaxVatAmountController = _controller;
      } else if (widget.fieldName == 'discount_%') {
        _amountDiscProvider.setDiscountPercentController = _controller;
      } else if (widget.fieldName == 'discount_amount') {
        _amountDiscProvider.setDiscountAmountController = _controller;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      child: TextFormField(
        controller: _controller,
        style: kTitleSmall.copyWith(color: kPrimaryColor),
        decoration: InputDecoration(
          hintText: widget.append ?? 'Enter price',
          hintStyle: kTitleSmall.copyWith(
            color: widget.amountFocusNode.hasFocus ? kPrimaryColor : kWhite,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
        // readOnly: widget.readOnly ?? false,
        focusNode: widget.amountFocusNode,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        onSaved: (amount) {
          if (amount == null) return;
          if (widget.fieldName == 'tax_vat_amount') {
            _amountDiscProvider.reset();
          } else if (widget.fieldName == 'discount_amount') {
            _amountDiscProvider.reset();
          }
          widget.amountCallBack(amount);
        },
        onChanged: (amount) {
          if (widget.fieldName == 'amount') {
            if (amount.isNotEmpty && double.tryParse(amount) != null) {
              _amountDiscProvider.amount = double.parse(amount);
              if (!_amountDiscProvider.isTaxVatPercentZero) {
                _amountDiscProvider.getTaxVatAmountController.text =
                    _amountDiscProvider.getTaxVatAmount.toInt().toString();
              }
              // _amountDiscProvider.getTaxVatPercentController.text =
              //     _amountDiscProvider.getTaxVatPercent.toInt().toString();
              if (!_amountDiscProvider.isDiscountPercentZero) {
                _amountDiscProvider.getDiscountAmountController.text =
                    _amountDiscProvider.getDiscountAmount.toInt().toString();
              }
              // _amountDiscProvider.getDiscountPercentController.text =
              //     _amountDiscProvider.getDiscountPercent.toInt().toString();
            }
          } else if (widget.fieldName == 'tax_vat_%') {
            if (amount.isNotEmpty && double.tryParse(amount) != null) {
              _amountDiscProvider.taxVatPercentage = double.parse(amount);
              _amountDiscProvider.getTaxVatAmountController.text =
                  _amountDiscProvider.getTaxVatAmount.toInt().toString();
            }
          } else if (widget.fieldName == 'tax_vat_amount') {
            if (amount.isNotEmpty && double.tryParse(amount) != null) {
              _amountDiscProvider.taxVatAmount = double.parse(amount);
              _amountDiscProvider.getTaxVatPercentController.text =
                  _amountDiscProvider.getTaxVatPercent.toInt().toString();
            }
          } else if (widget.fieldName == 'discount_%') {
            if (amount.isNotEmpty && double.tryParse(amount) != null) {
              _amountDiscProvider.discountPercentage = double.parse(amount);
              _amountDiscProvider.getDiscountAmountController.text =
                  _amountDiscProvider.getDiscountAmount.toInt().toString();
            }
          } else if (widget.fieldName == 'discount_amount') {
            if (amount.isNotEmpty && double.tryParse(amount) != null) {
              _amountDiscProvider.discountAmount = double.parse(amount);
              _amountDiscProvider.getDiscountPercentController.text =
                  _amountDiscProvider.getDiscountPercent.toInt().toString();
            }
          }
        },
        validator: (amount) {
          if (amount == null || amount.isEmpty) {
            return 'Please provide price';
          } else if (double.tryParse(amount) == null) {
            return 'Please provide valid number';
          }
          return null;
        },
      ),
    );
  }
}
