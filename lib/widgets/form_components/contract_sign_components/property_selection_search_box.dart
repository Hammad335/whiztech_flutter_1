import 'package:flutter/material.dart';
import '../../../constants/constants.dart';

class PropertySelectionSearchBox extends StatefulWidget {
  final FocusNode propertySelectionFocusNode;
  final Function propertySelectionCallBack;

  PropertySelectionSearchBox({
    required this.propertySelectionCallBack,
    required this.propertySelectionFocusNode,
  });

  @override
  State<PropertySelectionSearchBox> createState() =>
      _PropertySelectionSearchBoxState();
}

class _PropertySelectionSearchBoxState
    extends State<PropertySelectionSearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(top: 6),
      child: TextFormField(
        style: kTitleSmall.copyWith(color: kPrimaryColor),
        decoration: InputDecoration(
          hintText: 'Search client here ',
          contentPadding: const EdgeInsets.only(top: 6, left: 12),
          hintStyle: kTitleSmall.copyWith(
            color: widget.propertySelectionFocusNode.hasFocus
                ? kPrimaryColor
                : kWhite,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kPrimaryColor),
          ),
        ),
        focusNode: widget.propertySelectionFocusNode,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        onSaved: (propertySelection) {
          if (propertySelection == null) return;
          widget.propertySelectionCallBack(propertySelection);
        },
        // validator: (propertySelection) {
        //   if (propertySelection == null || propertySelection.isEmpty) {
        //     return 'Please select property';
        //   }
        //   return null;
        // },
      ),
    );
  }
}
