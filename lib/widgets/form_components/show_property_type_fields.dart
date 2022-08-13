import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/providers/property_type/property_type_provider.dart';
import 'package:whiztech_flutter_first_project/utils/form_validator.dart';
import 'package:whiztech_flutter_first_project/widgets/form_components/reused_fields/custom_textform_field.dart';
import '../bottom_sheet_field.dart';

class ShowPropertyTypeFields extends StatefulWidget {
  const ShowPropertyTypeFields({Key? key}) : super(key: key);

  @override
  State<ShowPropertyTypeFields> createState() => _ShowPropertyTypeFieldsState();
}

class _ShowPropertyTypeFieldsState extends State<ShowPropertyTypeFields> {
  final _nameFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  late PropertyTypeProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<PropertyTypeProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _locationFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BottomSheetField(
          title: 'Name : ',
          child: CustomTextFormField(
            firstFocusNode: _nameFocusNode,
            nextFocusNode: _locationFocusNode,
            currentFieldCallBack: _nameCallBack,
            hintText: 'Enter name here',
            keyboardType: TextInputType.name,
            validationCallBack: FormValidator.validateName,
          ),
        ),
        BottomSheetField(
          title: 'Location : ',
          child: CustomTextFormField(
            firstFocusNode: _locationFocusNode,
            currentFieldCallBack: _locationCallBack,
            hintText: 'Enter location',
            keyboardType: TextInputType.text,
            validationCallBack: FormValidator.validateLocation,
          ),
        ),
      ],
    );
  }

  void _nameCallBack(String name) {
    provider.name = name;
  }

  void _locationCallBack(String location) {
    provider.location = location;
  }
}
