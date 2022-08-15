import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/providers/client_creation/clients.dart';
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
  late Clients provider;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<Clients>(context, listen: false);
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
          focusNode: widget.clientSelectionFocusNode,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
        ),
        suggestionsCallback: (pattern) async {
          return provider.getClientTypes(pattern);
          // return provider.getPropertyTypes;
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
        onSaved: (clientSelection) {
          if (clientSelection == null) return;
          widget.clientSelectionCallBack(clientSelection);
        },
        validator: (clientSelection) {
          if (clientSelection == null || clientSelection.isEmpty) {
            return 'Please select client';
          }
          if (!provider.doesExist(clientSelection)) {
            return 'client does not exist';
          }
          return null;
        },
      ),
    );
  }
}
