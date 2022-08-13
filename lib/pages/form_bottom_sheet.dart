import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import '../providers/user.dart' as userProvider;
import '../widgets/form_components/contract_sign_components/show_contract_sign_fields.dart';
import '../widgets/form_components/create_property_components/show_create_property_fields.dart';
import '../widgets/form_components/show_property_type_fields.dart';
import '../widgets/form_components/show_client_creation_fields.dart';
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  cards[widget.index].cardName,
                  style: kTitleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 40),
                if (selectedCard == cards[0].cardName)
                  const ShowClientCreationFields(),
                if (selectedCard == cards[1].cardName)
                  const ShowPropertyTypeFields(),
                if (selectedCard == cards[2].cardName)
                  const ShowCreatePropertyFields(), // Create Property
                if (selectedCard == cards[3].cardName)
                  ShowContractSignFields(), // Contract Sign
                const SizedBox(height: 30),
                Container(
                  width: 120,
                  padding: MediaQuery.of(context).viewInsets,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: SaveFormButton(
                    onSavePressed: () async {
                      if (Utils.saveForm(_form)) {
                        try {
                          late Map<String, Object> json;
                          if (selectedCard == fieldNames[0]) {
                            // client creation card
                            // get current client
                            final clientProvider = Provider.of<ClientProvider>(
                                context,
                                listen: false);
                            final client = clientProvider.getClient;
                            Provider.of<Clients>(context, listen: false)
                                .addClient(client);
                            json = client.toJson();
                          } else if (selectedCard == fieldNames[1]) {
                            // property type card
                            // get current property type
                            final propertyTypeProvider =
                                Provider.of<PropertyTypeProvider>(context,
                                    listen: false);
                            final propertyType =
                                propertyTypeProvider.getPropertyType;
                            Provider.of<PropertyTypes>(context, listen: false)
                                .addPropertyType(propertyType);
                            json = propertyType.toJson();
                          } else if (selectedCard == fieldNames[2]) {
                            // create property card
                            // get current property
                            final propertyProvider =
                                Provider.of<PropertyProvider>(context,
                                    listen: false);
                            final property = propertyProvider.getProperty;
                            Provider.of<Properties>(context, listen: false)
                                .addProperty(property);
                            json = property.toJson();
                          } else if (selectedCard == fieldNames[3]) {
                            // contract sign card
                            Provider.of<ContractSignAmountDiscProvider>(context,
                                    listen: false)
                                .reset();
                            final contractProvider =
                                Provider.of<ContractSignProvider>(context,
                                    listen: false);
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

  Future uploadToFirestore(Map<String, Object> json) async {
    try {
      await _firestore
          .collection('forms')
          .doc(_currentUser.userId)
          .collection(selectedCard)
          .add(json);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      // Utils.showSnackBar(context, e.message.toString(), 2000);
    } catch (e) {
      String errorMessage = e.toString().split(':').last.trim();
      // Utils.showSnackBar(context, errorMessage, 2000);
    }
  }
}
