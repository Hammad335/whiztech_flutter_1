import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class LocationTextFormField extends StatefulWidget {
  final FocusNode locationFocusNode;
  Function locationCallBack;

  LocationTextFormField(
      {required this.locationFocusNode, required this.locationCallBack});

  @override
  State<LocationTextFormField> createState() => _LocationTextFormFieldState();
}

class _LocationTextFormFieldState extends State<LocationTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: kTitleSmall.copyWith(color: kPrimaryColor),
      decoration: InputDecoration(
        hintText: 'Enter location ',
        hintStyle: kTitleSmall.copyWith(
          color: widget.locationFocusNode.hasFocus ? kPrimaryColor : kWhite,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
        ),
      ),
      focusNode: widget.locationFocusNode,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      onSaved: (location) {
        if (location == null) return;
        widget.locationCallBack(location);
      },
      validator: (location) {
        if (location == null || location.isEmpty) {
          return 'Please provide location';
        }
        return null;
      },
    );
  }
}
