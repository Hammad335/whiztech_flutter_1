import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class ClientSelectionSearchBox extends StatefulWidget {
  final FocusNode clientSelectionFocusNode;
  final Function clientSelectionCallBack;

  ClientSelectionSearchBox({
    required this.clientSelectionCallBack,
    required this.clientSelectionFocusNode,
  });

  @override
  State<ClientSelectionSearchBox> createState() =>
      _ClientSelectionSearchBoxState();
}

class _ClientSelectionSearchBoxState extends State<ClientSelectionSearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(top: 6),
      child: TextFormField(
        style: kTitleSmall.copyWith(color: kPrimaryColor),
        decoration: InputDecoration(
          hintText: 'Search client here ',
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.only(top: 6, left: 12),
          hintStyle: kTitleSmall.copyWith(
            color: widget.clientSelectionFocusNode.hasFocus
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
        focusNode: widget.clientSelectionFocusNode,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        onSaved: (clientSelection) {
          if (clientSelection == null) return;
          widget.clientSelectionCallBack(clientSelection);
        },
        // validator: (clientSelection) {
        //   if (clientSelection == null || clientSelection.isEmpty) {
        //     return 'Please select client';
        //   }
        //   return null;
        // },
      ),
    );
  }
}
