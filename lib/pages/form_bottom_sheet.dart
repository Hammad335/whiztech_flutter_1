import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/widgets/form_components/contract_sign_components/date_time_picker.dart';
import '../constants/DUMMY_DATA.dart';
import '../constants/constants.dart';
import '../models/client.dart';
import '../models/property_type.dart';
import '../providers/card_state_provider.dart';
import '../utils/utils.dart';
import '../widgets/bottom_sheet_field.dart';
import '../providers/user.dart' as userProvider;
import '../widgets/form_components/contract_sign_components/amount_textform_field.dart';
import '../widgets/form_components/location_textform_field.dart';
import '../widgets/form_components/size_textform_field.dart';
import '../widgets/form_components/contract_sign_components/client_selection_search_box.dart';
import '../widgets/form_components/contract_sign_components/property_selection_search_box.dart';
import '../widgets/form_components/property_type_textform_field.dart';
import '../widgets/save_form_button.dart';

class FormBottomSheet extends StatefulWidget {
  final index;

  FormBottomSheet({required this.index});

  @override
  State<FormBottomSheet> createState() => _FormBottomSheetState();
}

class _FormBottomSheetState extends State<FormBottomSheet> {
  final GlobalKey<FormState> _form = GlobalKey();
  final _firestore = FirebaseFirestore.instance;
  late userProvider.User _currentUser;
  String _name = '';
  String _email = '';
  String _phone = '';
  String _address = '';
  String _location = '';
  String _size = '';
  String _propertyType = '';
  String _clientSelection = '';
  String _propertySelection = '';
  String _contractStartDate = '';
  String _contractEndDate = '';
  double _amount = 0.0;
  double _taxVatPercentage = 0.0;
  double _taxVatAmount = 0.0;
  double _discountPercentage = 0.0;
  double _discountAmount = 0.0;
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _sizeFocusNode = FocusNode();
  final _propertyTypeFocusNode = FocusNode();
  final _clientSelectionFocusNode = FocusNode();
  final _propertySelectionFocusNode = FocusNode();
  final _startDateFocusNode = FocusNode();
  final _endDateFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();
  final _taxVatPercentFocusNode = FocusNode();
  final _taxVatAmountFocusNode = FocusNode();
  final _discountPercentFocusNode = FocusNode();
  final _discountAmountFocusNode = FocusNode();
  late String selectedCard;

  @override
  void initState() {
    super.initState();
    selectedCard = Provider.of<CardStateProvider>(context, listen: false)
        .getSelectedCard();
    _currentUser =
        Provider.of<userProvider.User>(context, listen: false).getCurrentUser;
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _locationFocusNode.dispose();
    _sizeFocusNode.dispose();
    _propertyTypeFocusNode.dispose();
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
    final fields = cardNames[selectedCard];
    final fieldNames = cardNames.keys.toList();
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Text(
                cardNames.keys.toList()[widget.index],
                style: kTitleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 40),
              if (fields!.contains('Client Selection'))
                BottomSheetField(
                  title: 'Client Selection : ',
                  child: ClientSelectionSearchBox(
                    clientSelectionFocusNode: _clientSelectionFocusNode,
                    clientSelectionCallBack: _clientSelectionCallBack,
                  ),
                ),
              if (fields.contains('Property Selection'))
                BottomSheetField(
                  title: 'Property Selection : ',
                  child: PropertySelectionSearchBox(
                    propertySelectionFocusNode: _propertySelectionFocusNode,
                    propertySelectionCallBack: _propertySelectionCallBack,
                  ),
                ),
              if (fields.contains('Contract Start Date'))
                BottomSheetField(
                  title: 'Contract Start Date :',
                  child: DateTimePicker(
                      dateTimeFocusNode: _startDateFocusNode,
                      dateTimeCallBack: _contractStartDateCallBack),
                ),
              if (fields.contains('Contract End Date'))
                BottomSheetField(
                  title: 'Contract End Date :',
                  child: DateTimePicker(
                      dateTimeFocusNode: _endDateFocusNode,
                      dateTimeCallBack: _contractEndDateCallBack),
                ),
              if (fields.contains('Amount'))
                BottomSheetField(
                  title: 'Amount :',
                  child: AmountTextFormField(
                    amountFocusNode: _amountFocusNode,
                    amountCallBack: _amountCallBack,
                  ),
                ),
              if (fields.contains('Tax/Vat %'))
                BottomSheetField(
                  title: 'Tax/Vat % :',
                  child: AmountTextFormField(
                    amountFocusNode: _taxVatPercentFocusNode,
                    amountCallBack: _taxVatPercentCallBack,
                    append: 'Enter percentage \'%\'',
                  ),
                ),
              if (fields.contains('Tax/Vat Amount'))
                BottomSheetField(
                  title: 'Tax/Vat Amount :',
                  child: AmountTextFormField(
                    amountFocusNode: _taxVatAmountFocusNode,
                    amountCallBack: _taxVatAmountCallBack,
                  ),
                ),
              if (fields.contains('Discount %'))
                BottomSheetField(
                  title: 'Discount % :',
                  child: AmountTextFormField(
                    amountFocusNode: _discountPercentFocusNode,
                    amountCallBack: _discountPercentCallBack,
                    append: 'Enter discount percentage \'%\'',
                  ),
                ),
              if (fields.contains('Discount Amount'))
                BottomSheetField(
                  title: 'Discount Amount :',
                  child: AmountTextFormField(
                    amountFocusNode: _discountAmountFocusNode,
                    amountCallBack: _discountAmountCallBack,
                  ),
                ),
              if (fields.contains('Name') || fields.contains('Client Name'))
                BottomSheetField(
                  title: '${fields[0]} : ',
                  child: TextFormField(
                    style: kTitleSmall.copyWith(color: kPrimaryColor),
                    decoration: InputDecoration(
                      hintText: 'Enter ${fields[0].toLowerCase()} here',
                      hintStyle: kTitleSmall.copyWith(
                        color: _nameFocusNode.hasFocus ? kPrimaryColor : kWhite,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                    focusNode: _nameFocusNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(
                          selectedCard == cardNames.keys.first
                              ? _phoneFocusNode
                              : _locationFocusNode);
                    },
                    onSaved: (clientName) {
                      if (clientName == null) return;
                      _name = clientName;
                    },
                    validator: (clientName) {
                      if (clientName == null || clientName.isEmpty) {
                        return 'Please provide name';
                      } else if (clientName.length <= 2) {
                        return 'Too short, can be b/w 2 to 20 characters';
                      } else if (clientName.length >= 21) {
                        return 'Too long, can be b/w 2 to 20 characters';
                      }
                      return null;
                    },
                  ),
                ),
              if (fields.contains('Size'))
                BottomSheetField(
                  title: 'Size',
                  child: SizeTextFormField(
                    sizeFocusNode: _sizeFocusNode,
                    propertyTypeFocusNode: _propertyTypeFocusNode,
                    sizeCallBack: _sizeCallBack,
                  ),
                ),
              if (fields.contains('Property Type'))
                BottomSheetField(
                  title: 'Property Type',
                  child: PropertyTypeTextFormField(
                    propertyTypeFocusNode: _propertyTypeFocusNode,
                    propertyTypeCallBack: _propertyTypeCallBack,
                  ),
                ),
              if (fields.contains('Phone'))
                BottomSheetField(
                  title: 'Phone : ',
                  child: TextFormField(
                    style: kTitleSmall.copyWith(color: kPrimaryColor),
                    decoration: InputDecoration(
                      hintText: 'Enter phone number ',
                      hintStyle: kTitleSmall.copyWith(
                        color:
                            _phoneFocusNode.hasFocus ? kPrimaryColor : kWhite,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                    focusNode: _phoneFocusNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                    onSaved: (phoneNumb) {
                      if (phoneNumb == null) return;
                      _phone = phoneNumb;
                    },
                    validator: (phoneNumb) {
                      if (phoneNumb == null || phoneNumb.isEmpty) {
                        return 'Please provide phone';
                      } else if (phoneNumb.length < 11 ||
                          phoneNumb.length > 11) {
                        return 'Invalid Number';
                      }
                      return null;
                    },
                  ),
                ),
              if (fields.contains('Email'))
                BottomSheetField(
                  title: 'Email',
                  child: TextFormField(
                    style: kTitleSmall.copyWith(
                      color: kPrimaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter email address',
                      hintStyle: kTitleSmall.copyWith(
                        color:
                            _emailFocusNode.hasFocus ? kPrimaryColor : kWhite,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    focusNode: _emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_addressFocusNode);
                    },
                    onSaved: (email) {
                      if (email == null) return;
                      _email = email;
                    },
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Please provide email address';
                      } else if (!email.endsWith('@gmail.com')) {
                        return 'Badly formatted';
                      }
                      return null;
                    },
                  ),
                ),
              if (fields.contains('Address'))
                BottomSheetField(
                  title: 'Address',
                  child: TextFormField(
                    style: kTitleSmall.copyWith(color: kPrimaryColor),
                    decoration: InputDecoration(
                      hintText: 'Enter address ',
                      hintStyle: kTitleSmall.copyWith(
                        color:
                            _addressFocusNode.hasFocus ? kPrimaryColor : kWhite,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                    focusNode: _addressFocusNode,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    onSaved: (address) {
                      if (address == null) return;
                      _address = address;
                    },
                    validator: (address) {
                      if (address == null || address.isEmpty) {
                        return 'Please provide address';
                      }
                      return null;
                    },
                  ),
                ),
              if (fields.contains('Location'))
                BottomSheetField(
                  title: 'Location',
                  child: LocationTextFormField(
                    locationFocusNode: _locationFocusNode,
                    locationCallBack: _locationCallBack,
                  ),
                ),
              const SizedBox(height: 30),
              Container(
                width: 120,
                padding: MediaQuery.of(context).viewInsets,
                margin: const EdgeInsets.only(bottom: 10),
                child: SaveFormButton(
                  onSavePressed: () async {
                    if (_saveForm()) {
                      try {
                        late Map<String, Object> json;
                        if (selectedCard == fieldNames[0]) {
                          Client client = Client(
                            name: _name,
                            phone: _phone,
                            email: _email,
                            address: _address,
                          );
                          // upload client to firestore
                          json = client.toJson();
                        } else if (selectedCard == fieldNames[1]) {
                          PropertyType propertyType = PropertyType(
                            name: _name,
                            location: _location,
                          );
                          // upload propertyType to firestore
                          json = propertyType.toJson();
                          // upload propertyType to firebase
                        } else if (selectedCard == fieldNames[2]) {
                        } else if (selectedCard == fieldNames[3]) {
                        } else if (selectedCard == fieldNames[4]) {
                        } else if (selectedCard == fieldNames[5]) {}
                        await uploadToFirestore(json);
                        Navigator.of(context).pop();
                      } catch (exception) {
                        print(exception.toString());
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _saveForm() {
    final isValid = _form.currentState
        ?.validate(); // calls onValidate method of each textFormField
    if (!isValid!) return false;
    _form.currentState?.save(); // calls onSaved method of each textFormField
    return true;
  }

  Future uploadToFirestore(Map<String, Object> json) async {
    try {
      await _firestore
          .collection('forms')
          .doc(_currentUser.userId)
          .collection(selectedCard)
          .add(json);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(context, e.message.toString(), 2000);
    } catch (e) {
      String errorMessage = e.toString().split(':').last.trim();
      Utils.showSnackBar(context, errorMessage, 2000);
    }
  }

  void _locationCallBack(String location) {
    _location = location;
  }

  void _sizeCallBack(String size) {
    _size = size;
  }

  void _propertyTypeCallBack(String propertyType) {
    _propertyType = propertyType;
  }

  void _clientSelectionCallBack(String clientSelection) {
    _clientSelection = clientSelection;
  }

  void _propertySelectionCallBack(String propertySelection) {
    _propertySelection = propertySelection;
  }

  void _contractStartDateCallBack(String dateTime) {
    _contractStartDate = dateTime;
  }

  void _contractEndDateCallBack(String dateTime) {
    _contractEndDate = dateTime;
  }

  void _amountCallBack(String amount) {
    _amount = double.parse(amount);
  }

  void _taxVatPercentCallBack(String percent) {
    _taxVatPercentage = double.parse(percent);
  }

  void _taxVatAmountCallBack(String taxVatAmount) {
    _taxVatAmount = double.parse(taxVatAmount);
  }

  void _discountPercentCallBack(String percent) {
    _discountPercentage = double.parse(percent);
  }

  void _discountAmountCallBack(String discountAmount) {
    _discountAmount = double.parse(discountAmount);
  }
}
