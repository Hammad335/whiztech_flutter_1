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

  ContractSelectionSearchBox({
    required this.firstFocusNode,
    required this.currentFieldCallBack,
    this.contractIdCallBack,
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
  late Contracts _contracts;
  late ReceivedAmounts _receivedAmounts;
  late TextEditingController _controller;

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
        ),
        focusNode: widget.firstFocusNode,
        textInputAction: TextInputAction.done,
        keyboardType: widget.keyboardType,
      ),
      suggestionsCallback: (pattern) async {
        return _contracts.getContractClients(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.toString()),
        );
      },
      onSuggestionSelected: (suggestion) {
        _controller.text = suggestion;
        widget.currentFieldCallBack(suggestion);
        if (widget.contractAmountController != null &&
            widget.contractDateController != null) {
          final selectedContract =
              _contracts.getSingleContract(suggestion.trim());
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
        }
      },
      onSaved: (value) {
        widget.currentFieldCallBack(value);
        widget.contractIdCallBack == null
            ? null
            : widget
                .contractIdCallBack!(_contracts.getContractIdByName(value!));
      },
      validator: (value) => widget.validationCallBack(value, context),
    );
  }
}
