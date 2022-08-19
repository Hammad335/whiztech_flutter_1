import 'package:flutter/material.dart';

import '../../models/contract.dart';

class LedgerBalances with ChangeNotifier {
  List<Contract> _ledgerBalanceContracts = [];

  List<Contract> get ledgerBalanceContracts {
    return [..._ledgerBalanceContracts];
  }

  double get getTotalDebit {
    double total = 0.0;
    for (var contract in _ledgerBalanceContracts) {
      total += contract.netAmount;
    }
    return total;
  }

  void setContracts(List<Contract> contracts) {
    clear();
    _ledgerBalanceContracts = contracts;
    notifyListeners();
  }

  void clear() {
    _ledgerBalanceContracts.clear();
    _ledgerBalanceContracts = [];
  }
}
