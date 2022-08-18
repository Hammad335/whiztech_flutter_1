import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/utils/text_form_field_decoration.dart';
import '../../../constants/constants.dart';
import '../../../providers/contract_sign_amount_disc_provider.dart';

class AmountTextFormField extends StatefulWidget {
  final FocusNode amountFocusNode;
  Function amountCallBack;
  String hint;
  bool? readOnly;
  String fieldName;

  AmountTextFormField({
    required this.hint,
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
    _setControllerToProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(left: 6),
      child: TextFormField(
        controller: _controller,
        style: kTitleSmall.copyWith(color: kPrimaryColor),
        decoration: TextFormFieldDecoration.underlinedFormFieldDecoration(
          hintText: widget.hint,
          focusNode: widget.amountFocusNode,
        ),
        focusNode: widget.amountFocusNode,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        onSaved: (amount) {
          widget.amountCallBack(amount);
        },
        onChanged: (amount) {
          _amountDiscProvider.onChanged(widget.fieldName, amount);
        },
        validator: (amount) {
          if (amount == null || amount.isEmpty) {
            return 'Please provide number';
          } else if (double.tryParse(amount) == null) {
            return 'Please provide valid number';
          }
          return null;
        },
      ),
    );
  }

  void _setControllerToProvider() {
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
}
