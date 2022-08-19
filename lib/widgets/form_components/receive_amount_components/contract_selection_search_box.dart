import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/providers/received_amounts/received_amounts.dart';
import 'package:whiztech_flutter_first_project/utils/text_form_field_decoration.dart';
import '../../../constants/constants.dart';
import '../../../providers/contract_sign/contracts.dart';

class ContractSelectionSearchBox extends StatefulWidget {
  final FocusNode firstFocusNode;
  Function currentFieldCallBack;
  Function? contractIdCallBack;
  String hintText;
  final TextInputType keyboardType;
  final TextEditingController? contractDateController;
  final TextEditingController? contractAmountController;
  Function(String?, BuildContext) validationCallBack;
  Color? hintTextColor;
  IconData? prefixIconData;

  ContractSelectionSearchBox({
    required this.firstFocusNode,
    required this.currentFieldCallBack,
    this.contractIdCallBack,
    required this.hintText,
    required this.keyboardType,
    this.contractDateController,
    this.contractAmountController,
    required this.validationCallBack,
    this.hintTextColor,
    this.prefixIconData,
  });

  @override
  State<ContractSelectionSearchBox> createState() =>
      _ContractSelectionSearchBoxState();
}

class _ContractSelectionSearchBoxState
    extends State<ContractSelectionSearchBox> {
  late Contracts _contracts;
  late ReceivedAmounts _receivedAmounts;
  late TextEditingController _controller;
  String contractId = '';

  @override
  void initState() {
    super.initState();
    _contracts = Provider.of<Contracts>(context, listen: false);
    _receivedAmounts = Provider.of<ReceivedAmounts>(context, listen: false);
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
        if (widget.contractAmountController == null &&
            widget.contractDateController == null) {
          return _contracts.getDistinctContractClients(pattern);
        }
        return _contracts.getContractClients(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.split(':').first),
        );
      },
      onSuggestionSelected: (suggestion) {
        _controller.text = suggestion.split(':').first;
        if (widget.contractAmountController != null &&
            widget.contractDateController != null) {
          contractId = suggestion.split(':').last;
          final selectedContract = _contracts.getSingleContractById(contractId);
          final receivedAmount =
              _receivedAmounts.getByContractId(selectedContract.id!);
          double receivedDouble = 0.0;
          if (receivedAmount != null) {
            receivedDouble = receivedAmount.receiveAmount;
          }
          double remainingAmount = selectedContract.netAmount - receivedDouble;
          widget.contractAmountController!.text =
              remainingAmount.toStringAsFixed(1);
          widget.contractDateController!.text =
              selectedContract.contractStartDate;
        } else {
          widget.currentFieldCallBack(suggestion.split(':').first);
        }
      },
      onSaved: (value) {
        widget.currentFieldCallBack(value);
        widget.contractIdCallBack == null
            ? null
            : widget.contractIdCallBack!(contractId);
      },
      validator: (value) => widget.validationCallBack(value, context),
    );
  }
}
