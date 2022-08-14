import 'package:flutter/material.dart';

import '../constants/constants.dart';

class RegisterLoginButton extends StatefulWidget {
  Function onPressed;
  bool createAccount;

  RegisterLoginButton({required this.onPressed, required this.createAccount});

  @override
  State<RegisterLoginButton> createState() => _RegisterLoginButtonState();
}

class _RegisterLoginButtonState extends State<RegisterLoginButton> {
  var showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          print('called');
          setState(() {
            print('true');
            showSpinner = true;
          });
          widget.onPressed().then((_) {
            setState(() {
              print('then');
              showSpinner = false;
            });
          });
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kPrimaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: kWhite),
              ),
            )),
        child: showSpinner
            ? const Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child:
                      CircularProgressIndicator(color: kWhite, strokeWidth: 2),
                ),
              )
            : Text(
                widget.createAccount ? 'Register' : 'Login',
                style: const TextStyle(
                  color: kWhite,
                  fontSize: 18,
                  letterSpacing: 1.5,
                ),
              ),
      ),
    );
  }
}
