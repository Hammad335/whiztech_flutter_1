import 'package:flutter/material.dart';
import 'package:whiztech_flutter_first_project/constants/constants.dart';

class FormCard extends StatelessWidget {
  final String cardName;

  FormCard({required this.cardName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        cardName,
        style: kTitleMedium.copyWith(fontSize: 16),
      ),
    );
  }
}
