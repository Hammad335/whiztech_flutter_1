import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../providers/property_provider.dart';

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
  late PropertyProvider provider;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<PropertyProvider>(context, listen: false);
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      margin: const EdgeInsets.only(top: 6),
      child: TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: _controller,
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
          focusNode: widget.propertySelectionFocusNode,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
        ),
        suggestionsCallback: (pattern) async {
          return provider.getProperties(pattern);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            leading: const Icon(Icons.perm_identity_sharp),
            title: Text(suggestion.toString()),
          );
        },
        onSuggestionSelected: (suggestion) {
          _controller.text = suggestion;
        },
        onSaved: (propertySelection) {
          if (propertySelection == null) return;
          widget.propertySelectionCallBack(propertySelection);
        },
        validator: (propertySelection) {
          if (propertySelection == null || propertySelection.isEmpty) {
            return 'Please select property';
          }
          if (!provider.doesExist(propertySelection)) {
            return 'Property type does not exist';
          }
          return null;
        },
      ),
    );
  }
}
