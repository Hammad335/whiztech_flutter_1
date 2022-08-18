import 'package:flutter/material.dart';

import '../../models/contract.dart';

class LedgerBalances with ChangeNotifier {
  List<Contract> _ledgerBalanceContracts = [];

  List<Contract> get ledgerBalanceContracts {
    return [..._ledgerBalanceContracts];
  }

  void setContracts(List<Contract> contracts) {
    _ledgerBalanceContracts = contracts;
    notifyListeners();
  }
}
