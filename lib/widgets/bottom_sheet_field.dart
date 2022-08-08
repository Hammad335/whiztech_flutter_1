import 'package:flutter/material.dart';

import '../constants/constants.dart';

class BottomSheetField extends StatelessWidget {
  String title;
  TextFormField textFormField;
  BottomSheetField({required this.title, required this.textFormField});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 95,
              child: Text(
                title,
                style: kTitleSmall.copyWith(color: kPrimaryColor),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: textFormField,
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
