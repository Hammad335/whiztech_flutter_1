import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:whiztech_flutter_first_project/constants/constants.dart';
import 'package:whiztech_flutter_first_project/providers/contract_sign/contracts.dart';
import 'package:whiztech_flutter_first_project/providers/ledger_balace/ledger_balances.dart';
import 'package:whiztech_flutter_first_project/providers/received_amounts/received_amounts.dart';
import 'package:whiztech_flutter_first_project/utils/form_validator.dart';
import 'package:whiztech_flutter_first_project/widgets/form_components/receive_amount_components/contract_selection_search_box.dart';

import '../widgets/ledger_balace_row.dart';

class LedgerBalancePage extends StatefulWidget {
  static const routeName = 'ledger-balance-page';

  @override
  State<LedgerBalancePage> createState() => _LedgerBalancePageState();
}

class _LedgerBalancePageState extends State<LedgerBalancePage> {
  final _searchContractFocusNode = FocusNode();
  late Contracts _contracts;
  late LedgerBalances _ledgerBalances;
  late ReceivedAmounts _receivedAmounts;

  @override
  void initState() {
    super.initState();
    _contracts = Provider.of<Contracts>(context, listen: false);
    _ledgerBalances = Provider.of<LedgerBalances>(context, listen: false);
    _receivedAmounts = Provider.of<ReceivedAmounts>(context, listen: false);
  }

  @override
  void dispose() {
    _searchContractFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Ledger Balance'), backgroundColor: kPrimaryColor),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ContractSelectionSearchBox(
                  hintText: 'Search contract client',
                  firstFocusNode: _searchContractFocusNode,
                  currentFieldCallBack: _searchContractCallBack,
                  validationCallBack: FormValidator.validateContractClient,
                  keyboardType: TextInputType.name,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  SizedBox(
                    width: 44.w,
                    child: const Text(
                      'Contract Id',
                      style: kTitleSmallPrimary,
                    ),
                  ),
                  SizedBox(
                    width: 24.w,
                    child: const Text(
                      'Debit',
                      style: kTitleSmallPrimary,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                    child: const Text(
                      'Credit',
                      style: kTitleSmallPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Consumer<LedgerBalances>(builder: (context, provider, child) {
                return Column(
                  children: [
                    ...provider.ledgerBalanceContracts.map((contract) {
                      return LedgerBalanceRow(
                        contract: contract,
                        receivedAmount:
                            _receivedAmounts.getByContractId(contract.id!),
                      );
                    }).toList(),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _searchContractCallBack(String clientName) {
    _ledgerBalances.setContracts(_contracts.getContracts(clientName));
  }
}
