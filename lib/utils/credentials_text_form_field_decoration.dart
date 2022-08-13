import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CredentialsTextFormFieldDecoration {
  static InputDecoration decoration({
    required String hintText,
    required FocusNode focusNode,
    required IconData iconData,
    IconButton? suffixIconButton,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: kTitleSmall.copyWith(
        color: focusNode.hasFocus ? kPrimaryColor : Colors.white70,
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: kPrimaryColor,
          width: 2,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: kPrimaryColor,
          width: 2,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: kPrimaryColor,
          width: 2,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: kPrimaryColor,
          width: 2,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: kPrimaryColor,
          width: 2,
        ),
      ),
      fillColor: kCredentialTextFieldFillColor,
      filled: true,
      prefixIcon: Icon(
        iconData,
        color: kPrimaryColor,
      ),
      suffixIcon: suffixIconButton,
    );
  }
}
