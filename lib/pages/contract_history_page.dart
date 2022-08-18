import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/contract.dart';
import '../providers/contract_sign/contracts.dart';
import '../widgets/order_card_widget.dart';

class ContractHistoryPage extends StatelessWidget {
  static const routeName = 'contract-history-screen';
  late List<Contract> _allContracts;
  @override
  Widget build(BuildContext context) {
    _allContracts =
        Provider.of<Contracts>(context, listen: false).getAllContracts;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders History'),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: _allContracts.map((contract) {
              return OrderCardWidget(contract: contract);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
