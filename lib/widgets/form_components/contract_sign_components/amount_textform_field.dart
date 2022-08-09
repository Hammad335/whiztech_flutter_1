import 'package:flutter/material.dart';
import '../../../constants/constants.dart';

class AmountTextFormField extends StatefulWidget {
  final FocusNode amountFocusNode;
  Function amountCallBack;
  String? append;

  AmountTextFormField({
    this.append,
    required this.amountFocusNode,
    required this.amountCallBack,
  });

  @override
  State<AmountTextFormField> createState() => _AmountTextFormFieldState();
}

class _AmountTextFormFieldState extends State<AmountTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      child: TextFormField(
        style: kTitleSmall.copyWith(color: kPrimaryColor),
        decoration: InputDecoration(
          hintText: widget.append ?? 'Enter price ',
          hintStyle: kTitleSmall.copyWith(
            color: widget.amountFocusNode.hasFocus ? kPrimaryColor : kWhite,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
        focusNode: widget.amountFocusNode,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        onSaved: (amount) {
          if (amount == null) return;
          widget.amountCallBack(amount);
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
