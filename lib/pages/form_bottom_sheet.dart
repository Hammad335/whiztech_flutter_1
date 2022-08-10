import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/models/property.dart';
import 'package:whiztech_flutter_first_project/providers/client_creation/clients.dart';
import 'package:whiztech_flutter_first_project/providers/contract_sign/contract_sign_provider.dart';
import 'package:whiztech_flutter_first_project/providers/contract_sign_amount_disc_provider.dart';
import 'package:whiztech_flutter_first_project/providers/create_property/property_provider.dart';
import 'package:whiztech_flutter_first_project/providers/create_property/property_provider.dart';
import 'package:whiztech_flutter_first_project/providers/property_type/property_types.dart';
import 'package:whiztech_flutter_first_project/widgets/form_components/contract_sign_components/date_time_picker.dart';
import '../constants/DUMMY_DATA.dart';
import '../constants/constants.dart';
import '../models/client.dart';
import '../models/property_type.dart';
import '../providers/card_state_provider.dart';
import '../providers/create_property/properties.dart';
import '../utils/utils.dart';
import '../widgets/bottom_sheet_field.dart';
import '../providers/user.dart' as userProvider;
import '../widgets/form_components/contract_sign_components/show_contract_sign_fields.dart';
import '../widgets/form_components/contract_sign_components/amount_textform_field.dart';
import '../widgets/form_components/create_property_components/show_create_property_fields.dart';
import '../widgets/form_components/location_textform_field.dart';
import '../widgets/save_form_button.dart';
import '../providers/contract_sign_amount_disc_provider.dart';

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
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fields = cardNames[selectedCard];
    final fieldNames = cardNames.keys.toList();
    return WillPopScope(
      onWillPop: () async {
        Provider.of<ContractSignAmountDiscProvider>(context, listen: false)
            .reset();
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.of(context).pop();
        return false;
      },
      child: Container(
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
                if (selectedCard == cardNames.keys.toList()[2])
                  ShowCreatePropertyFields(), // Create Property
                if (selectedCard == cardNames.keys.toList()[3])
                  ShowContractSignFields(), // Contract Sign
                if (fields!.contains('Client Name') || fields.contains('Name '))
                  BottomSheetField(
                    title: '${fields[0]} : ',
                    child: TextFormField(
                      style: kTitleSmall.copyWith(color: kPrimaryColor),
                      decoration: InputDecoration(
                        hintText: 'Enter ${fields[0].toLowerCase()} here',
                        hintStyle: kTitleSmall.copyWith(
                          color:
                              _nameFocusNode.hasFocus ? kPrimaryColor : kWhite,
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
                          color: _addressFocusNode.hasFocus
                              ? kPrimaryColor
                              : kWhite,
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
                        final contractProvider =
                            Provider.of<ContractSignProvider>(context,
                                listen: false);
                        final propertyProvider = Provider.of<PropertyProvider>(
                            context,
                            listen: false);
                        try {
                          late Map<String, Object> json;
                          if (selectedCard == fieldNames[0]) {
                            Client client = Client(
                              name: _name,
                              phone: _phone,
                              email: _email,
                              address: _address,
                            );
                            Provider.of<Clients>(context, listen: false)
                                .addClient(client);
                            json = client.toJson();
                          } else if (selectedCard == fieldNames[1]) {
                            // property type card
                            PropertyType propertyType = PropertyType(
                              name: _name,
                              location: _location,
                            );
                            Provider.of<PropertyTypes>(context, listen: false)
                                .addPropertyType(propertyType);
                            json = propertyType.toJson();
                          } else if (selectedCard == fieldNames[2]) {
                            // create property card
                            // get current property
                            final property =
                                propertyProvider.getProperty.toJson();
                            // add to all properties
                            Provider.of<Properties>(context, listen: false)
                                .addProperty(Property(
                              name: property['name'] as String,
                              size: property['size'] as String,
                              propertyType: property['property type'] as String,
                            ));
                            json = property;
                          } else if (selectedCard == fieldNames[3]) {
                            // contract sign card
                            Provider.of<ContractSignAmountDiscProvider>(context,
                                    listen: false)
                                .reset();
                            json = contractProvider.getContract.toJson();
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
}
