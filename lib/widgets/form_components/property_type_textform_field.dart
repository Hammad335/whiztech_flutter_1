import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../providers/property_type_provider.dart';

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
  late PropertyTypeProvider provider;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<PropertyTypeProvider>(context, listen: false);
    _controller = TextEditingController();
  }

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
