import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/helpers/firebase_firestore_helper.dart';
import 'package:whiztech_flutter_first_project/providers/client_creation/client_provider.dart';
import 'package:whiztech_flutter_first_project/providers/client_creation/clients.dart';
import 'package:whiztech_flutter_first_project/providers/contract_sign/contract_sign_provider.dart';
import 'package:whiztech_flutter_first_project/providers/contract_sign_amount_disc_provider.dart';
import 'package:whiztech_flutter_first_project/providers/create_property/property_provider.dart';
import 'package:whiztech_flutter_first_project/providers/property_type/property_types.dart';
import '../constants/DUMMY_DATA.dart';
import '../constants/constants.dart';
import '../providers/card_state_provider.dart';
import '../providers/create_property/properties.dart';
import '../providers/property_type/property_type_provider.dart';
import '../utils/utils.dart';
import '../widgets/ShowSelectedCardFields.dart';
import '../widgets/save_form_button.dart';

class FormBottomSheet extends StatefulWidget {
  final index;

  FormBottomSheet({required this.index});

  @override
  State<FormBottomSheet> createState() => _FormBottomSheetState();
}

class _FormBottomSheetState extends State<FormBottomSheet> {
  final GlobalKey<FormState> _form = GlobalKey();
  late FirebaseFirestoreHelper _firebaseFirestoreHelper;
  late String selectedCard;

  @override
  void initState() {
    super.initState();
    selectedCard = Provider.of<CardStateProvider>(context, listen: false)
        .getSelectedCard();
    _firebaseFirestoreHelper = FirebaseFirestoreHelper();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  cards[widget.index].cardName,
                  style: kBottomSheetHeading,
                ),
                const SizedBox(height: 40),
                ShowSelectedCardFields(selectedCardIndex: widget.index),
                const SizedBox(height: 30),
                Container(
                  padding: MediaQuery.of(context).viewInsets,
                  child: SaveFormButton(
                    onSavePressed: () async {
                      if (Utils.saveForm(_form)) {
                        await _uploadToFirestore();
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

  Future<void> _uploadToFirestore() async {
    try {
      late Map<String, Object> json;
      if (selectedCard == cards[0].cardName) {
        // client creation card
        // get current client
        final clientProvider =
            Provider.of<ClientProvider>(context, listen: false);
        final client = clientProvider.getClient;
        Provider.of<Clients>(context, listen: false).addClient(client);
        json = client.toJson();
      } else if (selectedCard == cards[1].cardName) {
        // property type card
        // get current property type
        final propertyTypeProvider =
            Provider.of<PropertyTypeProvider>(context, listen: false);
        final propertyType = propertyTypeProvider.getPropertyType;
        Provider.of<PropertyTypes>(context, listen: false)
            .addPropertyType(propertyType);
        json = propertyType.toJson();
      } else if (selectedCard == cards[2].cardName) {
        // create property card
        // get current property
        final propertyProvider =
            Provider.of<PropertyProvider>(context, listen: false);
        final property = propertyProvider.getProperty;
        Provider.of<Properties>(context, listen: false).addProperty(property);
        json = property.toJson();
      } else if (selectedCard == cards[3].cardName) {
        // contract sign card
        Provider.of<ContractSignAmountDiscProvider>(context, listen: false)
            .reset();
        final contractProvider =
            Provider.of<ContractSignProvider>(context, listen: false);
        json = contractProvider.getContract.toJson();
      } else if (selectedCard == cards[4].cardName) {
      } else if (selectedCard == cards[5].cardName) {}
      await _firebaseFirestoreHelper.uploadFormData(json, selectedCard);
      _closeBottomSheet();
    } catch (exception) {
      print(exception.toString());
    }
  }

  void _closeBottomSheet() {
    Navigator.of(context).pop();
  }
}
