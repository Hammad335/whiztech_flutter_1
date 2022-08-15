import 'package:flutter/material.dart';
import 'form_components/show_contract_sign_fields.dart';
import 'form_components/show_create_property_fields.dart';
import 'form_components/show_client_creation_fields.dart';
import 'form_components/show_property_type_fields.dart';
import 'form_components/show_receive_amount_fields.dart';

class ShowSelectedCardFields extends StatelessWidget {
  int selectedCardIndex;

  ShowSelectedCardFields({required this.selectedCardIndex});

  Map<int, Widget> cardFields = {
    0: ShowClientCreationFields(),
    1: ShowPropertyTypeFields(),
    2: ShowCreatePropertyFields(),
    3: ShowContractSignFields(),
    5: ShowReceiveAmountFields(),
  };
  @override
  Widget build(BuildContext context) {
    return cardFields[selectedCardIndex]!;
  }
}
