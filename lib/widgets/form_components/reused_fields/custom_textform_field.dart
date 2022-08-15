import 'package:flutter/material.dart';
import 'package:whiztech_flutter_first_project/utils/text_form_field_decoration.dart';
import '../../../constants/constants.dart';

class CustomTextFormField extends StatefulWidget {
  final FocusNode firstFocusNode;
  final FocusNode? nextFocusNode;
  final TextInputType keyboardType;
  final String hintText;
  Function currentFieldCallBack;
  bool? readOnly;
  TextEditingController? currentController;
  TextEditingController? contractAmountController;
  TextEditingController? balanceAmountController;
  Function(String?) validationCallBack;

  CustomTextFormField({
    required this.firstFocusNode,
    this.nextFocusNode,
    required this.keyboardType,
    required this.hintText,
    required this.currentFieldCallBack,
    this.readOnly,
    this.currentController,
    this.contractAmountController,
    this.balanceAmountController,
    required this.validationCallBack,
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
      decoration: TextFormFieldDecoration.formFieldDecoration(
        hintText: widget.hintText,
        focusNode: widget.firstFocusNode,
      ),
      focusNode: widget.firstFocusNode,
      readOnly: widget.readOnly ?? false,
      textInputAction: widget.nextFocusNode == null
          ? TextInputAction.done
          : TextInputAction.next,
      keyboardType: widget.keyboardType,
      onChanged: (amount) {
        if (widget.contractAmountController != null) {
          if (amount.isEmpty || double.tryParse(amount) == null) {
            widget.balanceAmountController!.clear();
            return;
          }
          final balanceAmount =
              double.parse(widget.contractAmountController!.text) -
                  double.parse(amount);
          widget.balanceAmountController!.text = balanceAmount.toString();
        }
      },
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
