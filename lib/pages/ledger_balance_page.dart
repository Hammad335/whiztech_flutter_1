import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/constants/constants.dart';
import 'package:whiztech_flutter_first_project/helpers/pdf_print_helper.dart';
import 'package:whiztech_flutter_first_project/providers/contract_sign/contracts.dart';
import 'package:whiztech_flutter_first_project/providers/ledger_balace/ledger_balances.dart';
import 'package:whiztech_flutter_first_project/providers/received_amounts/received_amounts.dart';
import 'package:whiztech_flutter_first_project/utils/form_validator.dart';
import 'package:whiztech_flutter_first_project/widgets/form_components/receive_amount_components/contract_selection_search_box.dart';
import '../models/received_amount.dart';
import '../widgets/ledger_balance_row.dart';
import 'package:sizer/sizer.dart';

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_ledgerBalances.ledgerBalanceContracts.isEmpty) return;
          PdfPrintHelper.createPdfAndPrint(context);
        },
        label: const Text('Print'),
        icon: const Icon(Icons.print),
        backgroundColor: kPrimaryColor,
        extendedIconLabelSpacing: 15,
        extendedPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: WillPopScope(
        onWillPop: () async {
          _ledgerBalances.clear();
          return true;
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
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
                    hintTextColor: kPrimaryColor,
                    prefixIconData: Icons.search,
                  ),
                ),
                const SizedBox(height: 40),
                Consumer<LedgerBalances>(builder: (context, provider, child) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 6),
                        child: Column(
                          children: [
                            if (provider.ledgerBalanceContracts.isNotEmpty)
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20.w,
                                    child: const Text(
                                      'Id',
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
                                    width: 24.w,
                                    child: const Text(
                                      'Credit',
                                      style: kTitleSmallPrimary,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 24.w,
                                    child: const Text(
                                      'Balance',
                                      style: kTitleSmallPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 20),
                            ...provider.ledgerBalanceContracts.map((contract) {
                              final ReceivedAmount? rAmount = _receivedAmounts
                                  .getByContractId(contract.id!);
                              // if(rAmount!=null){
                              //   totalBalance+=
                              // }
                              return LedgerBalanceRow(
                                contract: contract,
                                receivedAmount: rAmount,
                              );
                            }).toList(),
                            const SizedBox(height: 40),
                            if (_ledgerBalances
                                .ledgerBalanceContracts.isNotEmpty)
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20.w,
                                    child: const Text(
                                      'Total :',
                                      style: kTitleSmallPrimary,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 24.w,
                                    child: Text(
                                      _ledgerBalances.getTotalDebit
                                          .toStringAsFixed(1),
                                      style: kTitleSmallBlack,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 24.w,
                                    child: Text(
                                      _receivedAmounts
                                          .getTotalCreditByName(_ledgerBalances
                                              .ledgerBalanceContracts[0]
                                              .clientSelection)
                                          .toStringAsFixed(1),
                                      style: kTitleSmallBlack,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 24.w,
                                    child: Text(
                                      (_ledgerBalances.getTotalDebit -
                                              _receivedAmounts
                                                  .getTotalCreditByName(
                                                      _ledgerBalances
                                                          .ledgerBalanceContracts[
                                                              0]
                                                          .clientSelection))
                                          .toStringAsFixed(1),
                                      style: kTitleSmallBlack,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _searchContractCallBack(String clientName) {
    _ledgerBalances.setContracts(_contracts.getContracts(clientName));
  }
}
