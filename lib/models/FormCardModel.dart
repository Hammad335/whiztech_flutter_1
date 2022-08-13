import 'package:flutter/material.dart';

class FormCardModel {
  String cardName;
  List<String> fieldNames;
  IconData iconData;

  FormCardModel({
    required this.cardName,
    required this.fieldNames,
    required this.iconData,
  });
}
