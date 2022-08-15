import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whiztech_flutter_first_project/constants/constants.dart';
import 'package:whiztech_flutter_first_project/models/property.dart';
import 'package:whiztech_flutter_first_project/models/property_type.dart';
import 'package:whiztech_flutter_first_project/models/received_amount.dart';
import 'package:whiztech_flutter_first_project/pages/form_bottom_sheet.dart';
import 'package:whiztech_flutter_first_project/providers/card_state_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whiztech_flutter_first_project/providers/client_creation/clients.dart';
import 'package:whiztech_flutter_first_project/providers/contract_sign_amount_disc_provider.dart';
import 'package:whiztech_flutter_first_project/providers/create_property/properties.dart';
import 'package:whiztech_flutter_first_project/providers/property_type/property_types.dart';
import '../models/client.dart';
import '../models/contract.dart';
import '../providers/contract_sign/contracts.dart';
import '../providers/received_amounts/received_amounts.dart';
import '../providers/user.dart' as userProvider;
import '../constants/DUMMY_DATA.dart';
import '../widgets/form_card.dart';
import 'package:provider/provider.dart';

import 'contract_history_page.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-screen';

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late String _uId;
  late Future<Map<dynamic, dynamic>> _userFuture;
  late Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _clientDataFuture;
  late Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _propertyTypeFuture;
  late Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _propertiesFuture;
  late Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _contractHistoryFuture;
  late Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _receiveAmountFuture;

  @override
  void initState() {
    _userFuture = getUser();
    _clientDataFuture = getClient();
    _propertiesFuture = getProperties();
    _propertyTypeFuture = getProperType();
    _contractHistoryFuture = getHistory();
    _receiveAmountFuture = getReceivedAmounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), backgroundColor: kPrimaryColor),
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([
            _userFuture,
            _clientDataFuture,
            _propertyTypeFuture,
            _propertiesFuture,
            _contractHistoryFuture,
            _receiveAmountFuture,
          ]),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor));
            }
            if (snapshot.hasError) {
              return const Center(
                  child: Text('Something went wrong, try again later.',
                      style: kTitleMedium));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              // set user
              final user = snapshot.data![0] as Map<String, dynamic>;
              Provider.of<userProvider.User>(context, listen: false).setUser(
                _uId,
                user['userName'] as String,
                user['email'] as String,
              );

              //populate clients data fetched from firestore
              final clientsList = snapshot.data![1]
                  as List<QueryDocumentSnapshot<Map<String, dynamic>>>;
              List<Client> lst1 = <Client>[];
              for (var type in clientsList) {
                lst1.add(Client.fromJson(type.data()));
              }
              Provider.of<Clients>(context, listen: false).populateClients =
                  lst1;

              // populate propertyType data fetched from firestore
              final propertyTypeList = snapshot.data![2]
                  as List<QueryDocumentSnapshot<Map<String, dynamic>>>;
              List<PropertyType> lst2 = [];
              for (var type in propertyTypeList) {
                lst2.add(PropertyType.fromJson(type.data()));
              }
              Provider.of<PropertyTypes>(context, listen: false)
                  .populatePropertyTypes = lst2;

              // populate properties data fetched from firestore
              final propertiesList = snapshot.data![3]
                  as List<QueryDocumentSnapshot<Map<String, dynamic>>>;
              List<Property> lst3 = [];
              for (var type in propertiesList) {
                lst3.add(Property.fromJson(type.data()));
              }
              Provider.of<Properties>(context, listen: false)
                  .populateProperties = lst3;

              // populate contract signs data fetched from firestore
              final contractsList = snapshot.data![4]
                  as List<QueryDocumentSnapshot<Map<String, dynamic>>>;
              List<Contract> lst4 = [];
              for (var type in contractsList) {
                final json = type.data()..putIfAbsent('id', () => type.id);
                lst4.add(Contract.fromJson(json));
              }
              Provider.of<Contracts>(context, listen: false).populateContracts =
                  lst4;
              // populate received amounts data fetched from firestore
              final receivedAmountsList = snapshot.data![5]
                  as List<QueryDocumentSnapshot<Map<String, dynamic>>>;
              List<ReceivedAmount> lst5 = [];
              for (var type in receivedAmountsList) {
                final json = type.data()..putIfAbsent('id', () => type.id);
                lst5.add(ReceivedAmount.fromJson(json));
              }
              Provider.of<ReceivedAmounts>(context, listen: false)
                  .populateReceivedAmounts = lst5;
              return Container(
                margin: const EdgeInsets.only(top: 110),
                child: GridView.count(
                  crossAxisCount: 3,
                  padding: const EdgeInsets.only(top: 40, left: 4, right: 4),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: List.generate(9, (index) {
                    return GestureDetector(
                      onTap: () {
                        Provider.of<CardStateProvider>(context, listen: false)
                            .setSelectedCard(cardNames.keys.toList()[index]);
                        if (index == 4) {
                          Navigator.of(context)
                              .pushNamed(ContractHistoryPage.routeName);
                          return;
                        }
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return SingleChildScrollView(
                                child: FormBottomSheet(index: index),
                              );
                            });
                      },
                      child: FormCard(cardModel: cards[index]),
                    );
                  }),
                ),
              );
            }
            return const Center(
                child: CircularProgressIndicator(color: kPrimaryColor));
          },
        ),
      ),
    );
  }

  Future<Map<dynamic, dynamic>> getUser() async {
    final User? user = auth.currentUser;
    _uId = user!.uid;
    final response = await _firestore.collection('users').get();
    return response.docs.first.data();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getClient() async {
    final response = await _firestore
        .collection('forms')
        .doc(_uId)
        .collection('Client Creation')
        .get();
    return response.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getProperType() async {
    final response = await _firestore
        .collection('forms')
        .doc(_uId)
        .collection('Property Type')
        .get();
    return response.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getProperties() async {
    final response = await _firestore
        .collection('forms')
        .doc(_uId)
        .collection('Create Property')
        .get();
    return response.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getHistory() async {
    final response = await _firestore
        .collection('forms')
        .doc(_uId)
        .collection('Contract Sign')
        .get();
    return response.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getReceivedAmounts() async {
    final response = await _firestore
        .collection('forms')
        .doc(_uId)
        .collection('Receive Amount')
        .get();
    return response.docs;
  }
}
