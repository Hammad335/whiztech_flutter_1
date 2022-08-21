import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/providers/client_creation/clients.dart';
import 'package:whiztech_flutter_first_project/providers/contract_sign/contract_sign_provider.dart';
import 'package:whiztech_flutter_first_project/providers/contract_sign_amount_disc_provider.dart';
import 'package:whiztech_flutter_first_project/providers/create_property/properties.dart';
import 'package:whiztech_flutter_first_project/utils/form_validator.dart';
import '../bottom_sheet_field.dart';
import 'reused_fields/date_time_picker.dart';
import 'reused_fields/custom_selection_search_box.dart';
import 'reused_fields/custom_textform_field.dart';

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
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _taxVatPercentController =
      TextEditingController();
  final TextEditingController _taxVatAmountController = TextEditingController();
  final TextEditingController _discountPercentController =
      TextEditingController();
  final TextEditingController _discountAmountController =
      TextEditingController();
  late ContractSignProvider _contractSignProvider;
  late Clients _clients;
  late Properties _properties;
  late ContractSignAmountDiscProvider _amountDiscProvider;

  @override
  void initState() {
    super.initState();
    _contractSignProvider =
        Provider.of<ContractSignProvider>(context, listen: false);
    _clients = Provider.of<Clients>(context, listen: false);
    _properties = Provider.of<Properties>(context, listen: false);
    _amountDiscProvider =
        Provider.of<ContractSignAmountDiscProvider>(context, listen: false);
    _setControllersToAmountDiscountProvider();
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
          child: CustomSelectionSearchBox(
            hintText: 'Search client here',
            firstFocusNode: _clientSelectionFocusNode,
            keyboardType: TextInputType.name,
            validationCallBack:
                FormValidator.validateContractClientCaseSensitive,
            onSavedCallBack: _clientSelectionOnSavedCallBack,
            suggestionsCallBack: _clientSuggestionsCallBack,
            onSuggestionSelectedCallBack: _onSuggestionSelectedCallBack,
            itemBuilderCallBack: _itemBuilderCallBack,
          ),
        ),
        BottomSheetField(
          title: 'Property Selection : ',
          child: CustomSelectionSearchBox(
            hintText: 'Search property here',
            firstFocusNode: _propertySelectionFocusNode,
            keyboardType: TextInputType.name,
            validationCallBack: FormValidator.validatePropertyNameCaseSensitive,
            itemBuilderCallBack: _itemBuilderCallBack,
            onSuggestionSelectedCallBack: _onSuggestionSelectedCallBack,
            suggestionsCallBack: _propertySuggestionsCallBack,
            onSavedCallBack: _propertySelectionOnSavedCallBack,
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
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Column(
            children: [
              BottomSheetField(
                title: 'Amount :',
                child: CustomTextFormField(
                  hintText: 'Enter contract amount',
                  firstFocusNode: _amountFocusNode,
                  keyboardType: TextInputType.number,
                  fieldName: 'amount',
                  currentController: _amountController,
                  currentFieldCallBack: _amountCallBack,
                  validationCallBack: FormValidator.validateAmount,
                  contractAmountOnChangedCallBack:
                      _contractAmountOnChangedCallBack,
                ),
              ),
              BottomSheetField(
                title: 'Tax/Vat % :',
                child: CustomTextFormField(
                  hintText: 'Enter tax/vat percentage %',
                  fieldName: 'tax_vat_%',
                  firstFocusNode: _taxVatPercentFocusNode,
                  validationCallBack: FormValidator.validateAmount,
                  currentFieldCallBack: _taxVatPercentCallBack,
                  keyboardType: TextInputType.number,
                  currentController: _taxVatPercentController,
                  contractAmountOnChangedCallBack:
                      _contractAmountOnChangedCallBack,
                ),
              ),
              BottomSheetField(
                title: 'Tax/Vat Amount :',
                child: CustomTextFormField(
                  hintText: 'Enter tax/vat amount',
                  firstFocusNode: _taxVatAmountFocusNode,
                  currentController: _taxVatAmountController,
                  fieldName: 'tax_vat_amount',
                  keyboardType: TextInputType.number,
                  currentFieldCallBack: _taxVatAmountCallBack,
                  validationCallBack: FormValidator.validateAmount,
                  contractAmountOnChangedCallBack:
                      _contractAmountOnChangedCallBack,
                ),
              ),
              BottomSheetField(
                title: 'Discount % :',
                child: CustomTextFormField(
                  hintText: 'Enter discount percentage %',
                  fieldName: 'discount_%',
                  keyboardType: TextInputType.number,
                  currentController: _discountPercentController,
                  firstFocusNode: _discountPercentFocusNode,
                  validationCallBack: FormValidator.validateAmount,
                  currentFieldCallBack: _discountPercentCallBack,
                  contractAmountOnChangedCallBack:
                      _contractAmountOnChangedCallBack,
                ),
              ),
              BottomSheetField(
                title: 'Discount Amount :',
                child: CustomTextFormField(
                  hintText: 'Enter discount amount',
                  fieldName: 'discount_amount',
                  keyboardType: TextInputType.number,
                  currentController: _discountAmountController,
                  firstFocusNode: _discountAmountFocusNode,
                  validationCallBack: FormValidator.validateAmount,
                  currentFieldCallBack: _discountAmountCallBack,
                  contractAmountOnChangedCallBack:
                      _contractAmountOnChangedCallBack,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _itemBuilderCallBack(context, suggestion) {
    return ListTile(
      title: Text(suggestion.toString()),
    );
  }

  List<String> _clientSuggestionsCallBack(String pattern) {
    return _clients.getClientTypes(pattern);
  }

  List<String> _propertySuggestionsCallBack(String pattern) {
    return _properties.getProperties(pattern);
  }

  void _onSuggestionSelectedCallBack(
      String suggestion, TextEditingController controller) {
    controller.text = suggestion;
  }

  void _contractAmountOnChangedCallBack(String amount, String fieldName) {
    _amountDiscProvider.onChanged(fieldName, amount);
  }

  void _clientSelectionOnSavedCallBack(String value) {
    _contractSignProvider.clientSelection = value;
  }

  void _propertySelectionOnSavedCallBack(String value) {
    _contractSignProvider.propertySelection = value;
  }

  void _contractStartDateCallBack(String dateTime) {
    _contractSignProvider.contractStartDate = dateTime;
  }

  void _contractEndDateCallBack(String dateTime) {
    _contractSignProvider.contractEndDate = dateTime;
  }

  void _amountCallBack(String amount) {
    final am = double.parse(amount);
    _contractSignProvider.amount = am;
  }

  void _taxVatPercentCallBack(String percent) {
    final perc = double.parse(percent);
    _contractSignProvider.taxVatPercentage = perc;
  }

  void _taxVatAmountCallBack(String taxVatAmount) {
    final am = double.parse(taxVatAmount);
    _contractSignProvider.taxVatAmount = am;
  }

  void _discountPercentCallBack(String percent) {
    final perc = double.parse(percent);
    _contractSignProvider.discountPercentage = perc;
  }

  void _discountAmountCallBack(String discountAmount) {
    final am = double.parse(discountAmount);
    _contractSignProvider.discountAmount = am;
  }

  void _setControllersToAmountDiscountProvider() {
    _amountDiscProvider.setTaxVatPercentController = _taxVatPercentController;
    _amountDiscProvider.setTaxVatAmountController = _taxVatAmountController;
    _amountDiscProvider.setDiscountPercentController =
        _discountPercentController;
    _amountDiscProvider.setDiscountAmountController = _discountAmountController;
  }
}
