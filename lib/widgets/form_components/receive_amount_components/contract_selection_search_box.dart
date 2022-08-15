import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/providers/received_amounts/received_amounts.dart';
import '../../../constants/constants.dart';
import '../../../providers/contract_sign/contracts.dart';

class ContractSelectionSearchBox extends StatefulWidget {
  final FocusNode firstFocusNode;
  Function currentFieldCallBack;
  Function contractIdCallBack;
  String hintText;
  final TextInputType keyboardType;
  final TextEditingController? contractDateController;
  final TextEditingController? contractAmountController;
  Function(String?, BuildContext) validationCallBack;

  ContractSelectionSearchBox({
    required this.firstFocusNode,
    required this.currentFieldCallBack,
    required this.contractIdCallBack,
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
        return _contracts.getContracts(pattern);
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
              _contracts.getSingleContract(suggestion.trim());
          final receivedAmount =
              _receivedAmounts.getByContractId(selectedContract.id!);
          double receivedDouble = 0.0;
          if (receivedAmount != null) {
            print(selectedContract.amount -
                selectedContract.taxVatAmount -
                selectedContract.discountAmount);
            receivedDouble = receivedAmount.receiveAmount;
          }
          double netAmount = selectedContract.amount -
              selectedContract.taxVatAmount -
              selectedContract.discountAmount -
              receivedDouble;
          widget.contractAmountController!.text = netAmount.toStringAsFixed(1);
          widget.contractDateController!.text =
              selectedContract.contractStartDate;
        }
      },
      onSaved: (value) {
        widget.currentFieldCallBack(value);
        widget.contractIdCallBack(_contracts.getContractIdByName(value!));
      },
      validator: (value) => widget.validationCallBack(value, context),
    );
  }
}
