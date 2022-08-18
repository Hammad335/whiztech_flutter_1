import 'package:flutter/material.dart';

import '../constants/constants.dart';

class AboutUsService extends StatelessWidget {
  String serviceText;

  AboutUsService({required this.serviceText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Text(
        serviceText,
        style: kTitleMediumBlack,
      ),
    );
  }
}
