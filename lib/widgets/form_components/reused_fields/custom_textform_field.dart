import 'package:flutter/material.dart';
import 'package:whiztech_flutter_first_project/utils/text_form_field_decoration.dart';
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
      decoration: TextFormFieldDecoration.formFieldDecoration(
        hintText: widget.hintText,
        focusNode: widget.firstFocusNode,
      ),
      focusNode: widget.firstFocusNode,
      textInputAction: widget.nextFocusNode == null
          ? TextInputAction.done
          : TextInputAction.next,
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
