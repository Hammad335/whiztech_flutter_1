import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class PropertyTypeTextFormField extends StatefulWidget {
  final FocusNode propertyTypeFocusNode;
  Function propertyTypeCallBack;

  PropertyTypeTextFormField({
    required this.propertyTypeFocusNode,
    required this.propertyTypeCallBack,
  });

  @override
  State<PropertyTypeTextFormField> createState() =>
      _PropertyTypeTextFormFieldState();
}

class _PropertyTypeTextFormFieldState extends State<PropertyTypeTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: kTitleSmall.copyWith(color: kPrimaryColor),
      decoration: InputDecoration(
        hintText: 'Enter property type ',
        hintStyle: kTitleSmall.copyWith(
          color: widget.propertyTypeFocusNode.hasFocus ? kPrimaryColor : kWhite,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
        ),
      ),
      focusNode: widget.propertyTypeFocusNode,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      onSaved: (propertyType) {
        if (propertyType == null) return;
        widget.propertyTypeCallBack(propertyType);
      },
      validator: (propertyType) {
        if (propertyType == null || propertyType.isEmpty) {
          return 'Please provide property category';
        }
        return null;
      },
    );
  }
}
