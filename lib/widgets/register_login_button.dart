import 'package:flutter/material.dart';

import '../constants/constants.dart';

class RegisterLoginButton extends StatelessWidget {
  VoidCallback onPressed;
  Widget child;

  RegisterLoginButton({required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kPrimaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: kWhite),
              ),
            )),
        child: child,
      ),
    );
  }
}
