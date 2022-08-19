import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whiztech_flutter_first_project/constants/constants.dart';
import 'package:whiztech_flutter_first_project/models/contract.dart';
import 'package:whiztech_flutter_first_project/models/received_amount.dart';

class LedgerBalanceRow extends StatelessWidget {
  final Contract contract;
  final ReceivedAmount? receivedAmount;

  LedgerBalanceRow({required this.contract, this.receivedAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 20.w,
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Text(
                contract.id!.substring(0, 4),
                style: kTitleSmallBlack,
              ),
            ),
          ),
          SizedBox(
            width: 24.w,
            child: Text(
              contract.netAmount.toStringAsFixed(1),
              style: kTitleSmallBlack,
              // textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            width: 24.w,
            child: Text(
              _getReceivedAmount,
              style: kTitleSmallBlack,
              // textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            width: 24.w,
            child: Text(
              (contract.netAmount - double.parse(_getReceivedAmount))
                  .toStringAsFixed(1),
              style: kTitleSmallBlack,
              // textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  String get _getReceivedAmount {
    return receivedAmount == null
        ? 0.0.toString()
        : receivedAmount!.receiveAmount.toStringAsFixed(1);
  }
}
