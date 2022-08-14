import 'package:flutter/material.dart';
import '../constants/constants.dart';

class SaveFormButton extends StatefulWidget {
  final Function onSavePressed;

  SaveFormButton({required this.onSavePressed});

  @override
  State<SaveFormButton> createState() => _SaveFormButtonState();
}

class _SaveFormButtonState extends State<SaveFormButton> {
  var _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            kPrimaryColor,
            Colors.greenAccent.withOpacity(0.4),
            kPrimaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _showSpinner = true;
          });
          widget.onSavePressed().then((_) {
            setState(() {
              _showSpinner = false;
            });
          });
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: _showSpinner
            ? const Center(
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(color: kWhite),
                ),
              )
            : const Text('Save'),
      ),
    );
  }
}
