import 'package:flutter/material.dart';

import '../models/FormCardModel.dart';

final List<FormCardModel> cards = [
  FormCardModel(
      cardName: 'Client Creation',
      fieldNames: ['Client Name', 'Phone', 'Email', 'Address'],
      iconData: Icons.person_add_outlined),
  FormCardModel(
      cardName: 'Property Type',
      fieldNames: ['Name ', 'Location'],
      iconData: Icons.account_balance_sharp),
  FormCardModel(
      cardName: 'Create Property',
      fieldNames: ['Name', 'Size', 'Property Type'],
      iconData: Icons.add_business),
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
      iconData: Icons.payments),
  FormCardModel(
      cardName: 'Contract History', fieldNames: [], iconData: Icons.history),
  FormCardModel(
      cardName: 'Receive Amount', fieldNames: [], iconData: Icons.attach_money),
  FormCardModel(
      cardName: 'Ledger Balance', fieldNames: [], iconData: Icons.add),
  FormCardModel(
      cardName: 'Coming Soon', fieldNames: [], iconData: Icons.upcoming),
  FormCardModel(
      cardName: 'Coming Soon', fieldNames: [], iconData: Icons.upcoming),
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
