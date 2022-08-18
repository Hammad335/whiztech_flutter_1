import 'package:flutter/material.dart';

import '../constants/constants.dart';

class AboutUsContactRow extends StatelessWidget {
  String iconPath;
  String title;

  AboutUsContactRow({required this.iconPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 45,
            height: 45,
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: kTitleMediumBlack,
          ),
        ],
      ),
    );
  }
}
