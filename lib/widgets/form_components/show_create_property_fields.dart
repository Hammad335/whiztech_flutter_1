import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/providers/create_property/property_provider.dart';
import 'package:whiztech_flutter_first_project/utils/form_validator.dart';
import 'package:whiztech_flutter_first_project/widgets/form_components/reused_fields/custom_textform_field.dart';
import '../bottom_sheet_field.dart';
import 'create_property_components/property_type_textform_field.dart';

class ShowCreatePropertyFields extends StatefulWidget {
  const ShowCreatePropertyFields({Key? key}) : super(key: key);

  @override
  State<ShowCreatePropertyFields> createState() =>
      _ShowCreatePropertyFieldsState();
}

class _ShowCreatePropertyFieldsState extends State<ShowCreatePropertyFields> {
  final _nameFocusNode = FocusNode();
  final _sizeFocusNode = FocusNode();
  final _propertyTypeFocusNode = FocusNode();
  late PropertyProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<PropertyProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    _nameFocusNode.dispose();
    _sizeFocusNode.dispose();
    _propertyTypeFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BottomSheetField(
            title: 'Name: ',
            child: CustomTextFormField(
              currentFieldCallBack: _nameCallBack,
              nextFocusNode: _sizeFocusNode,
              hintText: 'Enter name here',
              firstFocusNode: _nameFocusNode,
              keyboardType: TextInputType.name,
              validationCallBack: FormValidator.validatePropertyName,
              shouldPassContext: true,
            )),
        BottomSheetField(
          title: 'Size: ',
          child: CustomTextFormField(
            firstFocusNode: _sizeFocusNode,
            nextFocusNode: _propertyTypeFocusNode,
            hintText: 'Enter size',
            keyboardType: TextInputType.text,
            currentFieldCallBack: _sizeCallBack,
            validationCallBack: FormValidator.validateSize,
          ),
        ),
        BottomSheetField(
          title: 'Property Type',
          child: PropertyTypeTextFormField(
            propertyTypeFocusNode: _propertyTypeFocusNode,
            propertyTypeCallBack: _propertyTypeCallBack,
          ),
        ),
      ],
    );
  }

  void _nameCallBack(String name) {
    provider.name = name;
  }

  void _sizeCallBack(String size) {
    provider.size = size;
  }

  void _propertyTypeCallBack(String propertyType) {
    provider.propertyType = propertyType;
  }
}
