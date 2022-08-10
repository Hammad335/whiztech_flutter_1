import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../providers/property_type/property_types.dart';

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
  late PropertyTypes provider;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<PropertyTypes>(context, listen: false);
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _controller,
        style: kTitleSmall.copyWith(color: kPrimaryColor),
        decoration: InputDecoration(
          hintText: 'Search property type here ',
          contentPadding: const EdgeInsets.only(top: 6, left: 12),
          hintStyle: kTitleSmall.copyWith(
            color:
                widget.propertyTypeFocusNode.hasFocus ? kPrimaryColor : kWhite,
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
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.blue,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: kPrimaryColor,
            ),
          ),
        ),
        focusNode: widget.propertyTypeFocusNode,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
      ),
      suggestionsCallback: (pattern) async {
        return provider.getPropertyTypes(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.toString()),
        );
      },
      onSuggestionSelected: (suggestion) {
        _controller.text = suggestion;
      },
      onSaved: (propertySelection) {
        if (propertySelection == null) return;
        widget.propertyTypeCallBack(propertySelection);
      },
      validator: (propertyType) {
        if (propertyType == null || propertyType.isEmpty) {
          return 'Please select property type';
        }
        if (!provider.doesExist(propertyType)) {
          return 'Property type does not exist';
        }
        return null;
      },
    );
  }
}
