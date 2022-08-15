import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/widgets/form_components/receive_amount_components/contract_selection_search_box.dart';
import 'package:whiztech_flutter_first_project/widgets/form_components/reused_fields/custom_textform_field.dart';

import '../../providers/receive_amount/received_amount_provider.dart';
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
  final TextEditingController _receiveAmountController =
      TextEditingController();
  late ReceivedAmountProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<ReceivedAmountProvider>(context, listen: false);
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
          child: ContractSelectionSearchBox(
            firstFocusNode: _searchContractFocusNode,
            validationCallBack: FormValidator.validateContractClient,
            keyboardType: TextInputType.name,
            currentFieldCallBack: _contractCallBack,
            hintText: 'Search contract client here',
            contractAmountController: _contractAmountController,
            contractDateController: _contractDateController,
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
            currentController: _receiveAmountController,
            contractAmountController: _contractAmountController,
            balanceAmountController: _balanceAmountController,
            validationCallBack: FormValidator.validateReceivedAmount,
          ),
        ),
        BottomSheetField(
          title: 'Balance Amount: ',
          child: CustomTextFormField(
            hintText: 'Balance amount (auto generated)',
            currentFieldCallBack: _receiveAmountCallBack,
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

  void _contractCallBack(String contract) {
    provider.contract = contract;
  }

  void _contractDateCallBack(String contractDate) {
    provider.contractDate = contractDate;
  }

  void _contractAmountCallBack(String contractAmount) {
    provider.contractDate = contractAmount;
  }

  void _receiveAmountCallBack(double receiveAmount) {
    provider.receiveAmount = receiveAmount;
  }

  void _balanceAmountCallBack(double balanceAmount) {
    provider.balanceAmount = balanceAmount;
  }
}
