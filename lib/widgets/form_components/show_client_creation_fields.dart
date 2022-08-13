import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/providers/client_creation/client_provider.dart';
import '../../utils/form_validator.dart';
import 'reused_fields/custom_textform_field.dart';
import '../bottom_sheet_field.dart';

class ShowClientCreationFields extends StatefulWidget {
  const ShowClientCreationFields({Key? key}) : super(key: key);

  @override
  State<ShowClientCreationFields> createState() =>
      _ShowClientCreationFieldsState();
}

class _ShowClientCreationFieldsState extends State<ShowClientCreationFields> {
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  late ClientProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<ClientProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BottomSheetField(
          title: 'Client Name : ',
          child: CustomTextFormField(
            firstFocusNode: _nameFocusNode,
            nextFocusNode: _phoneFocusNode,
            currentFieldCallBack: _nameCallBack,
            hintText: 'Enter client name here',
            keyboardType: TextInputType.name,
            validationCallBack: FormValidator.validateName,
          ),
        ),
        BottomSheetField(
          title: 'Phone : ',
          child: CustomTextFormField(
            firstFocusNode: _phoneFocusNode,
            nextFocusNode: _emailFocusNode,
            currentFieldCallBack: _phoneCallBack,
            hintText: 'Enter phone number',
            keyboardType: TextInputType.phone,
            validationCallBack: FormValidator.validatePhone,
          ),
        ),
        BottomSheetField(
          title: 'Email : ',
          child: CustomTextFormField(
            firstFocusNode: _emailFocusNode,
            nextFocusNode: _addressFocusNode,
            currentFieldCallBack: _emailCallBack,
            hintText: 'Enter email address',
            keyboardType: TextInputType.emailAddress,
            validationCallBack: FormValidator.validateEmail,
          ),
        ),
        BottomSheetField(
          title: 'Address : ',
          child: CustomTextFormField(
            firstFocusNode: _addressFocusNode,
            currentFieldCallBack: _addressCallBack,
            hintText: 'Enter address',
            keyboardType: TextInputType.text,
            validationCallBack: FormValidator.validateAddress,
          ),
        ),
      ],
    );
  }

  void _nameCallBack(String name) {
    provider.name = name;
  }

  void _phoneCallBack(String phone) {
    provider.phone = phone;
  }

  void _emailCallBack(String email) {
    provider.phone = email;
  }

  void _addressCallBack(String address) {
    provider.phone = address;
  }
}
