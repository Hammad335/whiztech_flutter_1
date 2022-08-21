import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:whiztech_flutter_first_project/utils/text_form_field_decoration.dart';
import '../../../constants/constants.dart';

class CustomSelectionSearchBox extends StatefulWidget {
  final FocusNode firstFocusNode;
  String hintText;
  Function onSavedCallBack;
  Function onSuggestionSelectedCallBack;
  Function suggestionsCallBack;
  Function itemBuilderCallBack;
  TextInputType keyboardType;
  Function(String?, BuildContext) validationCallBack;
  Color? hintTextColor;
  IconData? prefixIconData;
  bool? isClient;

  CustomSelectionSearchBox({
    required this.firstFocusNode,
    required this.onSavedCallBack,
    required this.onSuggestionSelectedCallBack,
    required this.suggestionsCallBack,
    required this.itemBuilderCallBack,
    required this.hintText,
    required this.keyboardType,
    required this.validationCallBack,
    this.hintTextColor,
    this.prefixIconData,
    this.isClient,
  });

  @override
  State<CustomSelectionSearchBox> createState() =>
      _CustomSelectionSearchBoxState();
}

class _CustomSelectionSearchBoxState extends State<CustomSelectionSearchBox> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _controller,
        style: kTitleSmall.copyWith(color: kPrimaryColor),
        decoration: TextFormFieldDecoration.outlinedFormFieldDecoration(
            hintText: widget.hintText,
            focusNode: widget.firstFocusNode,
            borderRadius: 10.0,
            hintTextColor: widget.hintTextColor,
            prefixIconIconData: widget.prefixIconData),
        focusNode: widget.firstFocusNode,
        textInputAction: TextInputAction.done,
        keyboardType: widget.keyboardType,
      ),
      suggestionsCallback: (pattern) async {
        return widget.suggestionsCallBack(pattern);
      },
      itemBuilder: (context, suggestion) {
        return widget.itemBuilderCallBack(context, suggestion);
      },
      onSuggestionSelected: (suggestion) =>
          widget.onSuggestionSelectedCallBack(suggestion, _controller),
      onSaved: (value) => widget.onSavedCallBack(value),
      validator: (value) => widget.validationCallBack(value, context),
    );
  }
}
