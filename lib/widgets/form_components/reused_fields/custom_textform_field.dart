import 'package:flutter/material.dart';
import 'package:whiztech_flutter_first_project/utils/text_form_field_decoration.dart';
import '../../../constants/constants.dart';

class CustomTextFormField extends StatefulWidget {
  final FocusNode firstFocusNode;
  final FocusNode? nextFocusNode;
  final TextInputType keyboardType;
  final String hintText;
  Function currentFieldCallBack;
  Function validationCallBack;
  bool? readOnly;
  TextEditingController? currentController;
  bool? shouldPassContext;
  Function? onReceivedAmountChangeCallBack;
  Function? contractAmountOnChangedCallBack;
  String? fieldName;

  CustomTextFormField({
    required this.firstFocusNode,
    this.nextFocusNode,
    required this.keyboardType,
    required this.hintText,
    required this.currentFieldCallBack,
    this.readOnly,
    this.shouldPassContext,
    this.currentController,
    required this.validationCallBack,
    this.onReceivedAmountChangeCallBack,
    this.contractAmountOnChangedCallBack,
    this.fieldName,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.currentController,
      style: kTitleSmall.copyWith(color: kPrimaryColor),
      decoration: TextFormFieldDecoration.underlinedFormFieldDecoration(
        hintText: widget.hintText,
        focusNode: widget.firstFocusNode,
      ),
      focusNode: widget.firstFocusNode,
      readOnly: widget.readOnly ?? false,
      textInputAction: widget.nextFocusNode == null
          ? TextInputAction.done
          : TextInputAction.next,
      keyboardType: widget.keyboardType,
      onChanged: (value) {
        if (widget.onReceivedAmountChangeCallBack != null) {
          widget.onReceivedAmountChangeCallBack!(value);
        } else if (widget.contractAmountOnChangedCallBack != null) {
          widget.contractAmountOnChangedCallBack!(value, widget.fieldName);
        }
      },
      onFieldSubmitted: (_) {
        if (widget.nextFocusNode != null) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        }
      },
      onSaved: (value) => widget.currentFieldCallBack(value),
      validator: (String? value) => widget.shouldPassContext == null
          ? widget.validationCallBack(value)
          : widget.validationCallBack(value, context),
    );
  }
}
