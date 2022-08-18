import 'package:flutter/material.dart';

const Color kPrimaryColor = Colors.indigo;
Color kCredentialTextFieldFillColor = Colors.deepPurpleAccent.withOpacity(0.3);
const Color kSecondaryColor = Color(0xff212121);
const Color kWhite = Colors.white;
const Color kBlack = Colors.black;

const TextStyle kTitleSmall = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.normal,
  color: Colors.white,
);
const TextStyle kTitleSmallBlack = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.normal,
  color: kBlack,
);
const TextStyle kTitleSmallPrimary = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
);

const TextStyle kTitleMedium = TextStyle(
  fontSize: 19,
  fontWeight: FontWeight.normal,
  color: Colors.white,
);
const TextStyle kTitleMediumBold = TextStyle(
  fontSize: 19,
  fontWeight: FontWeight.bold,
  color: kBlack,
);
const TextStyle kBottomSheetHeading = TextStyle(
  fontSize: 19,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
  letterSpacing: 1,
);
const TextStyle kTitleLarge = TextStyle(
  fontSize: 22,
  color: kPrimaryColor,
  fontWeight: FontWeight.normal,
);

TextStyle kTitleLargeBold = kTitleLarge.copyWith(fontWeight: FontWeight.bold);

TextStyle kTitleExtraLarge = kTitleLargeBold.copyWith(fontSize: 25);
TextStyle kTitleMediumBlack =
    kTitleMedium.copyWith(color: kBlack, fontWeight: FontWeight.w500);
