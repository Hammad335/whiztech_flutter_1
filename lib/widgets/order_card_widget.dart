import 'package:flutter/material.dart';
import 'package:whiztech_flutter_first_project/constants/constants.dart';
import 'package:whiztech_flutter_first_project/providers/card_state_provider.dart';

import '../models/contract.dart';

class OrderCardWidget extends StatelessWidget {
  final Contract contract;

  OrderCardWidget({required this.contract});

  @override
  Widget build(BuildContext context) {
    final netAmount =
        contract.amount - contract.discountAmount - contract.taxVatAmount;
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: double.infinity),
                Text('Client Name',
                    style: kTitleMedium.copyWith(
                      color: kBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                  contract.clientSelection,
                  style: kTitleSmall.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Text('Contract Start Date: ',
                        style: kTitleSmall.copyWith(color: Colors.grey)),
                    Text(contract.contractStartDate,
                        style: kTitleSmall.copyWith(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Contract End Date: ',
                            style: kTitleSmall.copyWith(color: Colors.grey)),
                        Text(contract.contractEndDate,
                            style: kTitleSmall.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text(
                      netAmount.toStringAsFixed(1),
                      style: kTitleMedium.copyWith(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
