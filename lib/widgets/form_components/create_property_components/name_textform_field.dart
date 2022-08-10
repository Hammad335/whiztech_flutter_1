import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class NameTextFormField extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode sizeFocusNode;
  Function nameCallBack;

  NameTextFormField({
    required this.nameFocusNode,
    required this.sizeFocusNode,
    required this.nameCallBack,
  });

  @override
  State<NameTextFormField> createState() => _NameTextFormFieldState();
}

class _NameTextFormFieldState extends State<NameTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: kTitleSmall.copyWith(color: kPrimaryColor),
      decoration: InputDecoration(
        hintText: 'Enter name here',
        hintStyle: kTitleSmall.copyWith(
          color: widget.nameFocusNode.hasFocus ? kPrimaryColor : kWhite,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
        ),
      ),
      focusNode: widget.nameFocusNode,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(widget.sizeFocusNode);
      },
      onSaved: (propertyName) {
        if (propertyName == null) return;
        widget.nameCallBack(propertyName);
      },
      validator: (propertyName) {
        if (propertyName == null || propertyName.isEmpty) {
          return 'Please provide name';
        } else if (propertyName.length >= 21) {
          return 'Too long';
        }
        return null;
      },
    );
  }
}
