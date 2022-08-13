import 'package:flutter/material.dart';
import '../../../constants/constants.dart';

class CustomTextFormField extends StatefulWidget {
  final FocusNode firstFocusNode;
  final FocusNode? nextFocusNode;
  final TextInputType keyboardType;
  final String hintText;
  Function currentFieldCallBack;
  Function(String?) validationCallBack;

  CustomTextFormField({
    required this.firstFocusNode,
    this.nextFocusNode,
    required this.keyboardType,
    required this.hintText,
    required this.currentFieldCallBack,
    required this.validationCallBack,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: kTitleSmall.copyWith(color: kPrimaryColor),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: kTitleSmall.copyWith(
          color: widget.firstFocusNode.hasFocus ? kPrimaryColor : kWhite,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
        ),
      ),
      focusNode: widget.firstFocusNode,
      textInputAction:
          widget.nextFocusNode == null ? null : TextInputAction.next,
      keyboardType: widget.keyboardType,
      onFieldSubmitted: (_) {
        if (widget.nextFocusNode != null) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        }
      },
      onSaved: (value) => widget.currentFieldCallBack(value),
      validator: (String? value) => widget.validationCallBack(value),
    );
  }
}
