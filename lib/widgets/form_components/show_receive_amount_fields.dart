import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/providers/contract_sign/contracts.dart';
import 'package:whiztech_flutter_first_project/providers/received_amounts/received_amounts.dart';
import 'package:whiztech_flutter_first_project/widgets/form_components/reused_fields/custom_selection_search_box.dart';
import 'package:whiztech_flutter_first_project/widgets/form_components/reused_fields/custom_textform_field.dart';
import '../../providers/received_amounts/received_amount_provider.dart';
import '../../utils/form_validator.dart';
import '../bottom_sheet_field.dart';

class ShowReceiveAmountFields extends StatefulWidget {
  const ShowReceiveAmountFields({Key? key}) : super(key: key);

  @override
  State<ShowReceiveAmountFields> createState() =>
      _ShowReceiveAmountFieldsState();
}

class _ShowReceiveAmountFieldsState extends State<ShowReceiveAmountFields> {
  final _searchContractFocusNode = FocusNode();
  final _contractDateFocusNode = FocusNode();
  final _contractAmountFocusNode = FocusNode();
  final _receiveAmountFocusNode = FocusNode();
  final _balanceAmountFocusNode = FocusNode();
  final TextEditingController _contractAmountController =
      TextEditingController();
  final TextEditingController _contractDateController = TextEditingController();
  final TextEditingController _balanceAmountController =
      TextEditingController();
  late ReceivedAmountProvider _receivedAmountProvider;
  late Contracts _contracts;
  late ReceivedAmounts _receivedAmounts;

  @override
  void initState() {
    super.initState();
    _receivedAmountProvider =
        Provider.of<ReceivedAmountProvider>(context, listen: false);
    _contracts = Provider.of<Contracts>(context, listen: false);
    _receivedAmounts = Provider.of<ReceivedAmounts>(context, listen: false);
  }

  @override
  void dispose() {
    _searchContractFocusNode.dispose();
    _contractDateFocusNode.dispose();
    _contractAmountFocusNode.dispose();
    _receiveAmountFocusNode.dispose();
    _balanceAmountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BottomSheetField(
          title: 'Contract: ',
          child: CustomSelectionSearchBox(
            firstFocusNode: _searchContractFocusNode,
            validationCallBack:
                FormValidator.validateContractClientCaseSensitive,
            onSavedCallBack: _onSavedCallBack,
            onSuggestionSelectedCallBack: _onSuggestionSelectedCallBack,
            suggestionsCallBack: _suggestionsCallBack,
            itemBuilderCallBack: _itemBuilderCallBack,
            keyboardType: TextInputType.name,
            hintText: 'Search contract client here',
          ),
        ),
        BottomSheetField(
          title: 'Contract Date: ',
          child: CustomTextFormField(
            hintText: 'Start date (auto generated)',
            currentFieldCallBack: _contractDateCallBack,
            keyboardType: TextInputType.name,
            firstFocusNode: _contractDateFocusNode,
            readOnly: true,
            currentController: _contractDateController,
            validationCallBack: FormValidator.doNotValidate,
          ),
        ),
        BottomSheetField(
          title: 'Contract Amount: ',
          child: CustomTextFormField(
            hintText: 'Price (auto generated)',
            currentFieldCallBack: _contractAmountCallBack,
            keyboardType: TextInputType.name,
            firstFocusNode: _contractAmountFocusNode,
            readOnly: true,
            currentController: _contractAmountController,
            validationCallBack: FormValidator.doNotValidate,
          ),
        ),
        BottomSheetField(
          title: 'Receive Amount: ',
          child: CustomTextFormField(
            hintText: 'Enter receive amount',
            currentFieldCallBack: _receiveAmountCallBack,
            keyboardType: TextInputType.number,
            firstFocusNode: _receiveAmountFocusNode,
            validationCallBack: FormValidator.validateAmount,
            onReceivedAmountChangeCallBack: _onReceivedAmountChangeCallBack,
          ),
        ),
        BottomSheetField(
          title: 'Balance Amount: ',
          child: CustomTextFormField(
            hintText: 'Balance amount (auto generated)',
            currentFieldCallBack: _balanceAmountCallBack,
            keyboardType: TextInputType.number,
            firstFocusNode: _balanceAmountFocusNode,
            readOnly: true,
            currentController: _balanceAmountController,
            validationCallBack: FormValidator.doNotValidate,
          ),
        ),
      ],
    );
  }

  Widget _itemBuilderCallBack(context, suggestion) {
    return ListTile(
      title: Text(suggestion.split(':').first),
    );
  }

  List<String> _suggestionsCallBack(pattern) {
    return _contracts.getContractClients(pattern);
  }

  void _onSuggestionSelectedCallBack(
      String suggestion, TextEditingController controller) {
    controller.text = suggestion.split(':').first;
    final contractId = suggestion.split(':').last;
    _contractIdCallBack(contractId);
    final selectedContract = _contracts.getSingleContractById(contractId);
    final receivedAmount =
        _receivedAmounts.getByContractId(selectedContract.id!);
    double receivedDouble = 0.0;
    if (receivedAmount != null) {
      receivedDouble = receivedAmount.receiveAmount;
    }
    double remainingAmount = selectedContract.netAmount - receivedDouble;
    _contractAmountController.text = remainingAmount.toStringAsFixed(1);
    _contractDateController.text = selectedContract.contractStartDate;
  }

  void _onSavedCallBack(String contractClient) {
    _contractCallBack(contractClient);
  }

  void _onReceivedAmountChangeCallBack(String? amount) {
    // change balance amount on receive amount change
    if (amount == null || amount.isEmpty || double.tryParse(amount) == null) {
      _balanceAmountController.clear();
      return;
    }
    if (_contractAmountController.text.isEmpty) return;
    final balanceAmount =
        double.parse(_contractAmountController.text) - double.parse(amount);
    _balanceAmountController.text = balanceAmount.toStringAsFixed(1);
  }

  void _contractCallBack(String contract) {
    _receivedAmountProvider.contract = contract;
  }

  void _contractIdCallBack(String id) {
    _receivedAmountProvider.contractId = id;
  }

  void _contractDateCallBack(String contractDate) {
    _receivedAmountProvider.contractDate = contractDate;
  }

  void _contractAmountCallBack(String contractAmount) {
    _receivedAmountProvider.contractAmount = double.parse(contractAmount);
  }

  void _receiveAmountCallBack(String receiveAmount) {
    _receivedAmountProvider.receiveAmount = double.parse(receiveAmount);
  }

  void _balanceAmountCallBack(String balanceAmount) {
    _receivedAmountProvider.balanceAmount = double.parse(balanceAmount);
  }
}
