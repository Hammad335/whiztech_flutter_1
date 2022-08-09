import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class SizeTextFormField extends StatefulWidget {
  final FocusNode sizeFocusNode;
  final FocusNode propertyTypeFocusNode;
  Function sizeCallBack;

  SizeTextFormField({
    required this.sizeFocusNode,
    required this.propertyTypeFocusNode,
    required this.sizeCallBack,
  });

  @override
  State<SizeTextFormField> createState() => _SizeTextFormFieldState();
}

class _SizeTextFormFieldState extends State<SizeTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: kTitleSmall.copyWith(color: kPrimaryColor),
      decoration: InputDecoration(
        hintText: 'Enter size ',
        hintStyle: kTitleSmall.copyWith(
          color: widget.sizeFocusNode.hasFocus ? kPrimaryColor : kWhite,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
        ),
      ),
      focusNode: widget.sizeFocusNode,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(widget.propertyTypeFocusNode);
      },
      onSaved: (size) {
        if (size == null) return;
        widget.sizeCallBack(size);
      },
      validator: (size) {
        if (size == null || size.isEmpty) {
          return 'Please provide size';
        }
        return null;
      },
    );
  }
}
