import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whiztech_flutter_first_project/pages/about_us_page.dart';
import 'package:whiztech_flutter_first_project/pages/credentials_screen.dart';
import 'package:whiztech_flutter_first_project/pages/home_screen.dart';
import 'package:whiztech_flutter_first_project/providers/card_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/providers/client_creation/client_provider.dart';
import 'package:whiztech_flutter_first_project/providers/client_creation/clients.dart';
import 'package:whiztech_flutter_first_project/providers/contract_sign/contract_sign_provider.dart';
import 'package:whiztech_flutter_first_project/providers/contract_sign/contracts.dart';
import 'package:whiztech_flutter_first_project/providers/contract_sign_amount_disc_provider.dart';
import 'package:whiztech_flutter_first_project/providers/create_property/properties.dart';
import 'package:whiztech_flutter_first_project/providers/ledger_balace/ledger_balances.dart';
import 'package:whiztech_flutter_first_project/providers/property_type/property_type_provider.dart';
import 'package:whiztech_flutter_first_project/providers/create_property/property_provider.dart';
import 'package:whiztech_flutter_first_project/providers/property_type/property_types.dart';
import 'package:whiztech_flutter_first_project/providers/received_amounts/received_amounts.dart';
import 'package:whiztech_flutter_first_project/providers/user.dart';
import 'pages/contract_history_page.dart';
import 'providers/received_amounts/received_amount_provider.dart';
import 'package:sizer/sizer.dart';
import 'pages/ledger_balance_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CardStateProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => User(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContractSignProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Contracts(),
        ),
        ChangeNotifierProvider(
          create: (_) => PropertyTypes(),
        ),
        ChangeNotifierProvider(
          create: (_) => PropertyTypeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Clients(),
        ),
        ChangeNotifierProvider(
          create: (_) => ClientProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Properties(),
        ),
        ChangeNotifierProvider(
          create: (_) => PropertyProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContractSignAmountDiscProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReceivedAmountProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReceivedAmounts(),
        ),
        ChangeNotifierProvider(
          create: (_) => LedgerBalances(),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primaryColor: Colors.white),
            home: CredentialsScreen(),
            routes: {
              HomeScreen.routeName: (context) => HomeScreen(),
              ContractHistoryPage.routeName: (context) => ContractHistoryPage(),
              AboutUsPage.routeName: (context) => AboutUsPage(),
              LedgerBalancePage.routeName: (context) => LedgerBalancePage(),
            },
          );
        },
      ),
    );
  }
}
