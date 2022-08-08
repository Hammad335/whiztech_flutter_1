import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whiztech_flutter_first_project/pages/credentials_screen.dart';
import 'package:whiztech_flutter_first_project/pages/home_screen.dart';
import 'package:whiztech_flutter_first_project/providers/card_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/providers/user.dart';

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.white),
        home: CredentialsScreen(),
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
        },
      ),
    );
  }
}