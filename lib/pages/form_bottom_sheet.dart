import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/helpers/firebase_firestore_helper.dart';
import 'package:whiztech_flutter_first_project/helpers/process_and_upload_form_data.dart';
import 'package:whiztech_flutter_first_project/models/received_amount.dart';
import 'package:whiztech_flutter_first_project/providers/client_creation/client_provider.dart';
import 'package:whiztech_flutter_first_project/providers/client_creation/clients.dart';
import 'package:whiztech_flutter_first_project/providers/contract_sign/contract_sign_provider.dart';
import 'package:whiztech_flutter_first_project/providers/contract_sign_amount_disc_provider.dart';
import 'package:whiztech_flutter_first_project/providers/create_property/property_provider.dart';
import 'package:whiztech_flutter_first_project/providers/property_type/property_types.dart';
import '../constants/DUMMY_DATA.dart';
import '../constants/constants.dart';
import '../models/contract.dart';
import '../providers/card_state_provider.dart';
import '../providers/contract_sign/contracts.dart';
import '../providers/create_property/properties.dart';
import '../providers/property_type/property_type_provider.dart';
import '../providers/received_amounts/received_amount_provider.dart';
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
                        await ProcessAndUploadFormData.uploadToFirestore(
                            context, selectedCard);
                        _closeBottomSheet();
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

  void _closeBottomSheet() {
    Navigator.of(context).pop();
  }
}
