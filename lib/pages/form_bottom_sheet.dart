import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/DUMMY_DATA.dart';
import '../constants/constants.dart';
import '../models/client.dart';
import '../models/property_type.dart';
import '../providers/card_state_provider.dart';
import '../utils/utils.dart';
import '../widgets/bottom_sheet_field.dart';
import '../providers/user.dart' as userProvider;
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
              if (fields!.contains('Name') || fields.contains('Client Name'))
                BottomSheetField(
                  title: '${fields[0]} : ',
                  textFormField: TextFormField(
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
                        return 'Too short, can be b/w 2 to 7 characters';
                      } else if (clientName.length >= 7) {
                        return 'Too long, can be b/w 2 to 7 characters';
                      }
                      return null;
                    },
                  ),
                ),
              if (fields.contains('Phone'))
                BottomSheetField(
                  title: 'Phone : ',
                  textFormField: TextFormField(
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
                  textFormField: TextFormField(
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
                  textFormField: TextFormField(
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
                  textFormField: TextFormField(
                    style: kTitleSmall.copyWith(color: kPrimaryColor),
                    decoration: InputDecoration(
                      hintText: 'Enter location ',
                      hintStyle: kTitleSmall.copyWith(
                        color: _locationFocusNode.hasFocus
                            ? kPrimaryColor
                            : kWhite,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                    focusNode: _locationFocusNode,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    onSaved: (location) {
                      if (location == null) return;
                      _location = location;
                    },
                    validator: (location) {
                      if (location == null || location.isEmpty) {
                        return 'Please provide location';
                      }
                      return null;
                    },
                  ),
                ),
              const SizedBox(height: 30),
              Container(
                width: 120,
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
}
