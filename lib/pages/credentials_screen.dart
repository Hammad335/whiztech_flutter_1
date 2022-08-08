import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiztech_flutter_first_project/pages/home_screen.dart';
import '../constants/constants.dart';
import '../providers/user.dart' as userProvider;
import '../utils/utils.dart';

class CredentialsScreen extends StatefulWidget {
  @override
  State<CredentialsScreen> createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends State<CredentialsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _userNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _contactNoFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  String _username = '';
  String _email = '';
  String _password = '';
  var _createAccount = false;
  var _showPassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _userNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _contactNoFocusNode.dispose();
    _passwordFocusNode.dispose();
    // _forgotPasswordEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: kCredentialsBackgroundColor,
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_createAccount)
                    TextFormField(
                      style: kTitleSmall.copyWith(color: kPrimaryColor),
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: kTitleSmall.copyWith(
                          color: _userNameFocusNode.hasFocus
                              ? kPrimaryColor
                              : kWhite,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                      ),
                      focusNode: _userNameFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(
                            _createAccount ? _emailFocusNode : null);
                      },
                      onSaved: (userName) {
                        if (userName == null) return;
                        _username = userName;
                      },
                      validator: (userName) {
                        if (userName == null || userName.isEmpty) {
                          return 'Please provide username';
                        } else if (userName.length <= 2) {
                          return 'Too short, can be b/w 2 to 7 characters';
                        } else if (userName.length >= 7) {
                          return 'Too long, can be b/w 2 to 7 characters';
                        }
                        return null;
                      },
                    ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: kTitleSmall.copyWith(
                      color: kPrimaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: kTitleSmall.copyWith(
                        color:
                            _emailFocusNode.hasFocus ? kPrimaryColor : kWhite,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    focusNode: _emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    onSaved: (email) {
                      if (email == null) return;
                      _email = email;
                    },
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Please provide email address';
                      } else if (!email.endsWith('@gmail.com')) {
                        return 'Badly formatted';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: kTitleSmall.copyWith(color: kPrimaryColor),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: kTitleSmall.copyWith(
                        color: _passwordFocusNode.hasFocus
                            ? kPrimaryColor
                            : kWhite,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: _showPassword
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        color: kPrimaryColor,
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                    ),
                    obscureText: !_showPassword,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: _passwordFocusNode,
                    onSaved: (password) {
                      if (password == null) return;
                      _password = password;
                    },
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Please provide password';
                      } else if (password.length <= 5) {
                        return 'Too short, type at least 6 character';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _createAccount = !_createAccount;
                        });
                      },
                      child: Text(
                        _createAccount
                            ? 'Already have account? Login'
                            : 'Create new account',
                        textAlign: TextAlign.end,
                        style: const TextStyle(color: kWhite),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context).pushNamed(HomeScreen.routeName);
                        _createAccount ? _createNewUser() : _loginUser();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryColor),
                      ),
                      child: Text(_createAccount ? 'Register' : 'Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loginUser() async {
    if (_saveForm()) {
      try {
        final user = await _auth
            .signInWithEmailAndPassword(email: _email, password: _password)
            .timeout(const Duration(seconds: 5), onTimeout: () {
          throw Exception('Slow internet connection, try again later');
        });
        // navigate to home_screen
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        Utils.showSnackBar(context, e.message.toString(), 2000);
      } catch (e) {
        String errorMessage = e.toString().split(':').last.trim();
        Utils.showSnackBar(context, errorMessage, 2000);
      }
    }
  }

  Future<void> _createNewUser() async {
    if (_saveForm()) {
      try {
        // registering user on firebase
        final response = await _auth
            .createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        )
            .timeout(const Duration(seconds: 5), onTimeout: () {
          throw Exception('Slow internet connection, try again later');
        });

        // add user data to firestore
        await _firestore.collection('users').doc(response.user!.uid).set({
          'userName': _username,
          'email': _email,
        });
        setUserId(response);
        // Navigate to home_screen
        navigateToHomeScreen();
      } on FirebaseAuthException catch (e) {
        Utils.showSnackBar(context, e.message.toString(), 2000);
      } catch (e) {
        String errorMessage = e.toString().split(':').last.trim();
        Utils.showSnackBar(context, errorMessage, 2000);
      }
    }
  }

  bool _saveForm() {
    // setState(() {
    //   _submitted = true;
    // });
    final isValid = _formKey.currentState
        ?.validate(); // calls onValidate method of each textFormField
    if (!isValid!) return false;
    _formKey.currentState?.save(); // calls onSaved method of each textFormField
    return true;
  }

  void setUserId(UserCredential response) {
    Provider.of<userProvider.User>(context, listen: false)
        .setUserId(response.user!.uid);
  }

  void navigateToHomeScreen() {
    Navigator.of(context).pushNamed(HomeScreen.routeName);
  }
}
