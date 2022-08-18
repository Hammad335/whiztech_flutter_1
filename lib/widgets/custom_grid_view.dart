import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/widgets/form_card.dart';
import '../constants/DUMMY_DATA.dart';
import '../pages/about_us_page.dart';
import '../pages/contract_history_page.dart';
import '../pages/form_bottom_sheet.dart';
import '../pages/ledger_balance_page.dart';
import '../providers/card_state_provider.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.only(top: 40, left: 4, right: 4),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: List.generate(9, (index) {
          return GestureDetector(
            onTap: () {
              Provider.of<CardStateProvider>(context, listen: false)
                  .setSelectedCard(cardNames.keys.toList()[index]);
              if (index == 4) {
                Navigator.of(context).pushNamed(ContractHistoryPage.routeName);
                return;
              } else if (index == 6) {
                Navigator.of(context).pushNamed(LedgerBalancePage.routeName);
                return;
              } else if (index == 8) {
                Navigator.of(context).pushNamed(AboutUsPage.routeName);
                return;
              }
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: FormBottomSheet(index: index),
                    );
                  });
            },
            child: FormCard(cardModel: cards[index]),
          );
        }),
      ),
    );
  }
}
