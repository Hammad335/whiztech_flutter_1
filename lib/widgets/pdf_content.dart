import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/constants/constants.dart';
import 'package:whiztech_flutter_first_project/models/contract.dart';
import 'package:whiztech_flutter_first_project/models/received_amount.dart';
import 'package:whiztech_flutter_first_project/providers/ledger_balace/ledger_balances.dart';
import 'package:whiztech_flutter_first_project/providers/received_amounts/received_amounts.dart';

class PdfContent extends StatelessWidget {
  final ctxt;
  late LedgerBalances ledgerBalances;
  late ReceivedAmounts receivedAmounts;
  PdfContent({required this.ctxt});

  @override
  Widget build(Context context) {
    ledgerBalances = Provider.of<LedgerBalances>(ctxt, listen: false);
    receivedAmounts = Provider.of<ReceivedAmounts>(ctxt, listen: false);
    // return pdf widgets
    return Center(
      child: Column(
        children: [
          Header(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Contract Client : ${ledgerBalances.ledgerBalanceContracts[0].clientSelection}'),
                  Text('Whiztech Soluntions'),
                ]),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 6.4 * PdfPageFormat.cm,
                child: Text(
                  'Contract Id',
                  style: kPwTitleLargePrimary,
                ),
              ),
              SizedBox(
                width: 3.8 * PdfPageFormat.cm,
                child: Text(
                  'Debit',
                  style: kPwTitleLargePrimary,
                ),
              ),
              SizedBox(
                width: 3.8 * PdfPageFormat.cm,
                child: Text(
                  'Credit',
                  style: kPwTitleLargePrimary,
                ),
              ),
              SizedBox(
                width: 3.8 * PdfPageFormat.cm,
                child: Text(
                  'Balance',
                  style: kPwTitleLargePrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ...ledgerBalances.ledgerBalanceContracts
              .map((contract) => _ledgerRow(
                  contract: contract,
                  receivedAmount:
                      receivedAmounts.getByContractId(contract.id!)))
              .toList(),
          SizedBox(height: 40),
          Row(
            children: [
              SizedBox(
                width: 6.5 * PdfPageFormat.cm,
                child: Text(
                  'Total :',
                  style: kPwTitleLargePrimary,
                ),
              ),
              SizedBox(
                width: 3.8 * PdfPageFormat.cm,
                child: Text(
                  ledgerBalances.getTotalDebit.toStringAsFixed(1),
                ),
              ),
              SizedBox(
                width: 3.8 * PdfPageFormat.cm,
                child: Text(
                  receivedAmounts
                      .getTotalCreditByName(ledgerBalances
                          .ledgerBalanceContracts[0].clientSelection)
                      .toStringAsFixed(1),
                ),
              ),
              SizedBox(
                width: 3.8 * PdfPageFormat.cm,
                child: Text(
                  (ledgerBalances.getTotalDebit -
                          receivedAmounts.getTotalCreditByName(ledgerBalances
                              .ledgerBalanceContracts[0].clientSelection))
                      .toStringAsFixed(1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _ledgerRow(
      {required Contract contract, ReceivedAmount? receivedAmount}) {
    return Container(
      padding: const EdgeInsets.only(left: 4, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 6.4 * PdfPageFormat.cm,
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Text(
                contract.id!,
                softWrap: true,
                maxLines: 1,
              ),
            ),
          ),
          SizedBox(
            width: 3.8 * PdfPageFormat.cm,
            child: Text(
              contract.netAmount.toStringAsFixed(1),
            ),
          ),
          SizedBox(
            width: 3.8 * PdfPageFormat.cm,
            child: Text(
              _getReceivedAmount(receivedAmount),
            ),
          ),
          SizedBox(
            width: 3.8 * PdfPageFormat.cm,
            child: Text(
              (contract.netAmount -
                      double.parse(_getReceivedAmount(receivedAmount)))
                  .toStringAsFixed(1),
            ),
          ),
        ],
      ),
    );
  }

  static String _getReceivedAmount(ReceivedAmount? receivedAmount) {
    return receivedAmount == null
        ? 0.0.toString()
        : receivedAmount.receiveAmount.toStringAsFixed(1);
  }
}
