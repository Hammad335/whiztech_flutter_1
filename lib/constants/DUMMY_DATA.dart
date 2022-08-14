import 'package:flutter/material.dart';

import '../models/FormCardModel.dart';

final List<FormCardModel> cards = [
  FormCardModel(
      cardName: 'Client Creation',
      fieldNames: ['Client Name', 'Phone', 'Email', 'Address'],
      iconData: Icons.person_add_outlined,
      color: Colors.pinkAccent),
  FormCardModel(
      cardName: 'Property Type',
      fieldNames: ['Name ', 'Location'],
      iconData: Icons.account_balance_sharp,
      color: Colors.deepOrangeAccent),
  FormCardModel(
      cardName: 'Create Property',
      fieldNames: ['Name', 'Size', 'Property Type'],
      iconData: Icons.add_business,
      color: Colors.purpleAccent),
  FormCardModel(
      cardName: 'Contract Sign',
      fieldNames: [
        'Client Selection',
        'Property Selection',
        'Contract Start Date',
        'Contract End Date',
        'Amount',
        'Tax/Vat %',
        'Tax/Vat Amount',
        'Discount %',
        'Discount Amount',
      ],
      iconData: Icons.payments,
      color: Colors.lightBlueAccent),
  FormCardModel(
      cardName: 'Contract History',
      fieldNames: [],
      iconData: Icons.history,
      color: Colors.orangeAccent),
  FormCardModel(
      cardName: 'Receive Amount',
      fieldNames: [],
      iconData: Icons.attach_money,
      color: Colors.redAccent),
  FormCardModel(
      cardName: 'Ledger Balance',
      fieldNames: [],
      iconData: Icons.add,
      color: Colors.orange),
  FormCardModel(
      cardName: 'Coming Soon',
      fieldNames: [],
      iconData: Icons.upcoming,
      color: Colors.black54),
  FormCardModel(
      cardName: 'Coming Soon',
      fieldNames: [],
      iconData: Icons.upcoming,
      color: Colors.black54),
];
const Map<String, List<String>> cardNames = {
  'Client Creation': ['Client Name', 'Phone', 'Email', 'Address'],
  'Property Type': ['Name ', 'Location'],
  'Create Property': ['Name', 'Size', 'Property Type'],
  'Contract Sign': [
    'Client Selection',
    'Property Selection',
    'Contract Start Date',
    'Contract End Date',
    'Amount',
    'Tax/Vat %',
    'Tax/Vat Amount',
    'Discount %',
    'Discount Amount',
  ],
  'Contract History': [],
  'Receive Amount': [],
  'Ledger Balance': [],
  'Coming Soon': [],
  'Coming Soon.': [],
};
