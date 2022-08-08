import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whiztech_flutter_first_project/constants/constants.dart';
import 'package:whiztech_flutter_first_project/pages/form_bottom_sheet.dart';
import 'package:whiztech_flutter_first_project/providers/card_state_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/user.dart' as userProvider;
import '../constants/DUMMY_DATA.dart';
import '../widgets/form_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-screen';

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late String _uId;
  late Future<Map<dynamic, dynamic>> _userFuture;
  var bottomSheetController;

  @override
  void initState() {
    _userFuture = getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), backgroundColor: kPrimaryColor),
      body: SafeArea(
        child: FutureBuilder(
          future: _userFuture,
          builder: (BuildContext context,
              AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor));
            }
            if (snapshot.hasError) {
              return const Center(
                  child: Text('Something went wrong, try again later.',
                      style: kTitleMedium));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Provider.of<userProvider.User>(context, listen: false).setUser(
                _uId,
                snapshot.data!['userName'],
                snapshot.data!['email'],
              );
              return GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.only(top: 40, left: 4, right: 4),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(9, (index) {
                  return GestureDetector(
                    onTap: () {
                      Provider.of<CardStateProvider>(context, listen: false)
                          .setSelectedCard(cardNames.keys.toList()[index]);
                      bottomSheetController = showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return SingleChildScrollView(
                                child: FormBottomSheet(index: index));
                          });
                    },
                    child: FormCard(cardName: cardNames.keys.toList()[index]),
                  );
                }),
              );
            }
            return const Center(
                child: CircularProgressIndicator(color: kPrimaryColor));
          },
        ),
      ),
    );
  }

  Future<Map<dynamic, dynamic>> getUser() async {
    final User? user = auth.currentUser;
    _uId = user!.uid;
    final response = await _firestore.collection('users').get();
    return response.docs.first.data();
  }
}
