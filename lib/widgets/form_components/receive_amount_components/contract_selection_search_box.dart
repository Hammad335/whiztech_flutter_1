import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../providers/contract_sign/contracts.dart';

class ContractSelectionSearchBox extends StatefulWidget {
  final FocusNode firstFocusNode;
  Function currentFieldCallBack;
  String hintText;
  final TextInputType keyboardType;
  final TextEditingController? contractDateController;
  final TextEditingController? contractAmountController;
  Function(String?, BuildContext) validationCallBack;

  ContractSelectionSearchBox({
    required this.firstFocusNode,
    required this.currentFieldCallBack,
    required this.hintText,
    required this.keyboardType,
    this.contractDateController,
    this.contractAmountController,
    required this.validationCallBack,
  });

  @override
  State<ContractSelectionSearchBox> createState() =>
      _ContractSelectionSearchBoxState();
}

class _ContractSelectionSearchBoxState
    extends State<ContractSelectionSearchBox> {
  late Contracts provider;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<Contracts>(context, listen: false);
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _controller,
        style: kTitleSmall.copyWith(color: kPrimaryColor),
        decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: const EdgeInsets.only(top: 6, left: 12),
          hintStyle: kTitleSmall.copyWith(
            color: widget.firstFocusNode.hasFocus ? kPrimaryColor : kWhite,
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
        focusNode: widget.firstFocusNode,
        textInputAction: TextInputAction.done,
        keyboardType: widget.keyboardType,
      ),
      suggestionsCallback: (pattern) async {
        return provider.getContracts(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.toString()),
        );
      },
      onSuggestionSelected: (suggestion) {
        _controller.text = suggestion;
        if (widget.contractAmountController != null &&
            widget.contractDateController != null) {
          final selectedContract =
              provider.getSingleContract(suggestion.trim());
          final netAmount = selectedContract.amount -
              selectedContract.taxVatAmount -
              selectedContract.discountAmount;
          widget.contractAmountController!.text = netAmount.toString();
          widget.contractDateController!.text =
              selectedContract.contractStartDate;
        }
      },
      onSaved: (value) => widget.currentFieldCallBack(value),
      validator: (value) => widget.validationCallBack(value, context),
    );
  }
}
