import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/providers/contract_sign/contract_sign_provider.dart';
import '../contract_sign_components/client_selection_search_box.dart';
import '../../bottom_sheet_field.dart';
import '../contract_sign_components/amount_textform_field.dart';
import '../contract_sign_components/date_time_picker.dart';
import '../contract_sign_components/property_selection_search_box.dart';

class ShowContractSignFields extends StatefulWidget {
  @override
  State<ShowContractSignFields> createState() => _ShowContractSignFieldsState();
}

class _ShowContractSignFieldsState extends State<ShowContractSignFields> {
  final _clientSelectionFocusNode = FocusNode();
  final _propertySelectionFocusNode = FocusNode();
  final _startDateFocusNode = FocusNode();
  final _endDateFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();
  final _taxVatPercentFocusNode = FocusNode();
  final _taxVatAmountFocusNode = FocusNode();
  final _discountPercentFocusNode = FocusNode();
  final _discountAmountFocusNode = FocusNode();
  late ContractSignProvider contractSignProvider;

  @override
  void initState() {
    super.initState();
    contractSignProvider =
        Provider.of<ContractSignProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _clientSelectionFocusNode.dispose();
    _propertySelectionFocusNode.dispose();
    _startDateFocusNode.dispose();
    _endDateFocusNode.dispose();
    _amountFocusNode.dispose();
    _taxVatPercentFocusNode.dispose();
    _taxVatAmountFocusNode.dispose();
    _discountPercentFocusNode.dispose();
    _discountAmountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BottomSheetField(
          title: 'Client Selection : ',
          child: ClientSelectionSearchBox(
            clientSelectionFocusNode: _clientSelectionFocusNode,
            clientSelectionCallBack: _clientSelectionCallBack,
          ),
        ),
        BottomSheetField(
          title: 'Property Selection : ',
          child: PropertySelectionSearchBox(
            propertySelectionFocusNode: _propertySelectionFocusNode,
            propertySelectionCallBack: _propertySelectionCallBack,
          ),
        ),
        BottomSheetField(
          title: 'Contract Start Date :',
          child: DateTimePicker(
            dateTimeFocusNode: _startDateFocusNode,
            dateTimeCallBack: _contractStartDateCallBack,
            hint: 'Select start date ',
          ),
        ),
        BottomSheetField(
          title: 'Contract End Date :',
          child: DateTimePicker(
            dateTimeFocusNode: _endDateFocusNode,
            dateTimeCallBack: _contractEndDateCallBack,
            hint: 'Select end date ',
          ),
        ),
        BottomSheetField(
          title: 'Amount :',
          child: AmountTextFormField(
            amountFocusNode: _amountFocusNode,
            amountCallBack: _amountCallBack,
            fieldName: 'amount',
          ),
        ),
        BottomSheetField(
          title: 'Tax/Vat % :',
          child: AmountTextFormField(
            amountFocusNode: _taxVatPercentFocusNode,
            amountCallBack: _taxVatPercentCallBack,
            fieldName: 'tax_vat_%',
            append: 'Enter tax/vat Percentage %',
          ),
        ),
        BottomSheetField(
          title: 'Tax/Vat Amount :',
          child: AmountTextFormField(
            amountFocusNode: _taxVatAmountFocusNode,
            amountCallBack: _taxVatAmountCallBack,
            fieldName: 'tax_vat_amount',
            append: 'Amount (auto calculated)',
            readOnly: true,
          ),
        ),
        BottomSheetField(
          title: 'Discount % :',
          child: AmountTextFormField(
            amountFocusNode: _discountPercentFocusNode,
            amountCallBack: _discountPercentCallBack,
            fieldName: 'discount_%',
            append: 'Enter discount percentage \'%\'',
          ),
        ),
        BottomSheetField(
          title: 'Discount Amount :',
          child: AmountTextFormField(
            amountFocusNode: _discountAmountFocusNode,
            amountCallBack: _discountAmountCallBack,
            fieldName: 'discount_amount',
            append: 'Amount (auto calculated)',
            readOnly: true,
          ),
        ),
      ],
    );
  }

  void _clientSelectionCallBack(String clientSelection) {
    contractSignProvider.clientSelection = clientSelection;
  }

  void _propertySelectionCallBack(String propertySelection) {
    contractSignProvider.propertySelection = propertySelection;
  }

  void _contractStartDateCallBack(String dateTime) {
    contractSignProvider.contractStartDate = dateTime;
  }

  void _contractEndDateCallBack(String dateTime) {
    contractSignProvider.contractEndDate = dateTime;
  }

  void _amountCallBack(String amount) {
    final am = double.parse(amount);
    contractSignProvider.amount = am;
  }

  void _taxVatPercentCallBack(String percent) {
    final perc = double.parse(percent);
    contractSignProvider.taxVatPercentage = perc;
  }

  void _taxVatAmountCallBack(String taxVatAmount) {
    final am = double.parse(taxVatAmount);
    contractSignProvider.taxVatAmount = am;
  }

  void _discountPercentCallBack(String percent) {
    final perc = double.parse(percent);
    contractSignProvider.discountPercentage = perc;
  }

  void _discountAmountCallBack(String discountAmount) {
    final am = double.parse(discountAmount);
    contractSignProvider.discountAmount = am;
  }
}
