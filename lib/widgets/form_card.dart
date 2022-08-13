import 'package:flutter/material.dart';
import 'package:whiztech_flutter_first_project/constants/constants.dart';
import 'package:whiztech_flutter_first_project/models/FormCardModel.dart';

class FormCard extends StatelessWidget {
  final FormCardModel cardModel;

  FormCard({required this.cardModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            cardModel.iconData,
            size: 30,
            color: kPrimaryColor,
          ),
          Text(
            cardModel.cardName,
            style: kTitleMedium.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
