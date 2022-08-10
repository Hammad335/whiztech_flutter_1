import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  final FocusNode dateTimeFocusNode;
  final Function dateTimeCallBack;

  DateTimePicker({
    required this.dateTimeFocusNode,
    required this.dateTimeCallBack,
  });

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      child: TextFormField(
        controller: _controller,
        readOnly: true,
        style: kTitleSmall.copyWith(color: kPrimaryColor),
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.date_range_sharp, color: kPrimaryColor),
          hintText: 'Select end date ',
          hintStyle: kTitleSmall.copyWith(
            color: widget.dateTimeFocusNode.hasFocus ? kPrimaryColor : kWhite,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
        focusNode: widget.dateTimeFocusNode,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        onSaved: (dateTime) {
          if (dateTime == null) return;
          widget.dateTimeCallBack(dateTime);
        },
        validator: (dateTime) {
          if (dateTime == null || dateTime.isEmpty) {
            return 'Please select start date';
          }
          return null;
        },
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2050),
          );
          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            _controller.text = formattedDate;
            FocusScope.of(context).requestFocus(FocusNode()); //remove focus

          }
        },
      ),
    );
  }
}
