import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/helpers/firebase_firestore_helper.dart';
import 'package:whiztech_flutter_first_project/models/received_amount.dart';
import 'package:whiztech_flutter_first_project/providers/received_amounts/received_amounts.dart';
import '../constants/DUMMY_DATA.dart';
import '../models/contract.dart';
import '../providers/client_creation/client_provider.dart';
import '../providers/client_creation/clients.dart';
import '../providers/contract_sign/contract_sign_provider.dart';
import '../providers/contract_sign/contracts.dart';
import '../providers/contract_sign_amount_disc_provider.dart';
import '../providers/create_property/properties.dart';
import '../providers/create_property/property_provider.dart';
import '../providers/property_type/property_type_provider.dart';
import '../providers/property_type/property_types.dart';
import '../providers/received_amounts/received_amount_provider.dart';

class ProcessAndUploadFormData {
  static Future<void> uploadToFirestore(
      BuildContext context, String selectedCard) async {
    FirebaseFirestoreHelper firebaseFirestoreHelper = FirebaseFirestoreHelper();
    try {
      late Map<String, Object> json;
      if (selectedCard == cards[0].cardName) {
        // client creation card
        final client =
            Provider.of<ClientProvider>(context, listen: false).getClient;
        Provider.of<Clients>(context, listen: false).addClient(client);
        json = client.toJson();
      } else if (selectedCard == cards[1].cardName) {
        // property type card
        final propertyType =
            Provider.of<PropertyTypeProvider>(context, listen: false)
                .getPropertyType;
        Provider.of<PropertyTypes>(context, listen: false)
            .addPropertyType(propertyType);
        json = propertyType.toJson();
      } else if (selectedCard == cards[2].cardName) {
        // create property card
        final property =
            Provider.of<PropertyProvider>(context, listen: false).getProperty;
        Provider.of<Properties>(context, listen: false).addProperty(property);
        json = property.toJson();
      } else if (selectedCard == cards[3].cardName) {
        // contract sign card
        Provider.of<ContractSignAmountDiscProvider>(context, listen: false)
            .reset();
        final provider =
            Provider.of<ContractSignProvider>(context, listen: false);
        provider.setNetAmount();
        final contract = provider.getContract;
        final response = await firebaseFirestoreHelper.uploadFormData(
            contract.toJson(), selectedCard);
        addToCurrentContracts(context, contract, response.id);
        return;
      } else if (selectedCard == cards[4].cardName) {
      } else if (selectedCard == cards[5].cardName) {
        // Receive amount card
        final receivedAmount =
            Provider.of<ReceivedAmountProvider>(context, listen: false)
                .getReceivedAmount;
        final alreadyReceivedAmount =
            Provider.of<ReceivedAmounts>(context, listen: false)
                .getByContractId(receivedAmount.contractId);
        if (alreadyReceivedAmount != null) {
          receivedAmount.receiveAmount += alreadyReceivedAmount.receiveAmount;
          await firebaseFirestoreHelper.updateReceivedAmount(
              receivedAmount.toJson(),
              selectedCard,
              context,
              alreadyReceivedAmount.id!);
          updateCurrentReceivedAmount(context, receivedAmount);
          return;
        }
        final response = await firebaseFirestoreHelper.uploadFormData(
            receivedAmount.toJson(), selectedCard);
        addToCurrentReceivedAmount(context, receivedAmount, response.id);
        return;
      }
      await firebaseFirestoreHelper.uploadFormData(json, selectedCard);
    } catch (exception) {
      print(exception.toString());
    }
  }

  static addToCurrentContracts(
      BuildContext context, Contract contract, String id) {
    Provider.of<Contracts>(context, listen: false).addContract(contract, id);
  }

  static void addToCurrentReceivedAmount(
      BuildContext context, ReceivedAmount receivedAmount, String id) {
    Provider.of<ReceivedAmounts>(context, listen: false)
        .addReceivedAmount(receivedAmount, id);
  }

  static void updateCurrentReceivedAmount(
      BuildContext context, ReceivedAmount receivedAmount) {
    Provider.of<ReceivedAmounts>(context, listen: false)
        .updateReceivedAmount(receivedAmount);
  }
}
