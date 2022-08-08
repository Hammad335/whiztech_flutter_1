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
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _showSpinner = true;
        });
        widget.onSavePressed().then((_) {
          setState(() {
            _showSpinner = false;
            Navigator.of(context).pop();
          });
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kPrimaryColor),
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
    );
  }
}
