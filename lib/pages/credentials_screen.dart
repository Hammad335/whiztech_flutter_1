import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whiztech_flutter_first_project/pages/home_screen.dart';
import '../constants/constants.dart';
import '../utils/utils.dart';
import '../utils/credentials_text_form_field_decoration.dart';
import '../helpers/firebase_firestore_helper.dart';
import '../widgets/register_login_button.dart';

class CredentialsScreen extends StatefulWidget {
  @override
  State<CredentialsScreen> createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends State<CredentialsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late FirebaseFirestoreHelper _firebaseFirestoreHelper;
  final _userNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  String _username = '';
  String _email = '';
  String _password = '';
  var _createAccount = false;
  var _showPassword = false;

  @override
  void initState() {
    super.initState();
    _firebaseFirestoreHelper = FirebaseFirestoreHelper();
  }

  @override
  void dispose() {
    _userNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kCredentialsBackgroundColor,
            image: const DecorationImage(
              image: AssetImage('assets/images/credentials_background.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 90),
                      SizedBox(
                        height: 40,
                        child: Text(
                          _createAccount
                              ? 'Register Your Account'
                              : 'Login your Account',
                          style: kTitleLarge.copyWith(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _createAccount = !_createAccount;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _createAccount
                                  ? 'Already have account ?  '
                                  : 'New here ?  ',
                              style: kTitleSmall,
                            ),
                            Text(
                              _createAccount ? 'Login' : 'Register Now',
                              style: kTitleSmall.copyWith(color: kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 70),
                      AnimatedContainer(
                        height: _createAccount ? 74 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: AnimatedOpacity(
                          opacity: _createAccount ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: TextFormField(
                            style: kTitleSmall.copyWith(color: kPrimaryColor),
                            decoration:
                                CredentialsTextFormFieldDecoration.decoration(
                              hintText: 'Username',
                              focusNode: _userNameFocusNode,
                              iconData: Icons.perm_identity_sharp,
                            ),
                            focusNode: _userNameFocusNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(
                                  _createAccount ? _emailFocusNode : null);
                            },
                            onSaved: (userName) => _username = userName!,
                            validator: (userName) {
                              if (!_createAccount) {
                                return null;
                              } else {
                                Utils.userNameValidation(userName);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 74,
                        child: TextFormField(
                          style: kTitleSmall.copyWith(
                            color: kPrimaryColor,
                          ),
                          decoration:
                              CredentialsTextFormFieldDecoration.decoration(
                            hintText: 'Email',
                            focusNode: _emailFocusNode,
                            iconData: Icons.email_outlined,
                          ),
                          focusNode: _emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                          onSaved: (email) => _email = email!,
                          validator: Utils.emailValidation,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 74,
                        child: TextFormField(
                          style: kTitleSmall.copyWith(color: kPrimaryColor),
                          decoration:
                              CredentialsTextFormFieldDecoration.decoration(
                            hintText: 'Password',
                            focusNode: _passwordFocusNode,
                            iconData: Icons.password,
                            suffixIconButton: IconButton(
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
                          onSaved: (password) => _password = password!,
                          validator: Utils.passwordValidation,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: Text(
                          'Forgot password ?',
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.pink),
                        ),
                      ),
                      const SizedBox(height: 80),
                      RegisterLoginButton(
                        onPressed: () async {
                          if (Utils.saveForm(_formKey)) {
                            await _registerLoginUser();
                          }
                        },
                        createAccount: _createAccount,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/credentail_bottom_right_corner.png',
                        alignment: Alignment.bottomRight,
                        // scale: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _registerLoginUser() async {
    try {
      if (_createAccount) {
        // registering user on firebase
        final response = await _firebaseFirestoreHelper.registerUser(
            _username, _email, _password);
        // Navigate to home_screen
        navigateToHomeScreen(response: response);
      } else {
        // login user
        await _firebaseFirestoreHelper.loginUser(_email, _password);
        navigateToHomeScreen();
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(context, e.message.toString(), 2000);
    } catch (e) {
      String errorMessage = e.toString().split(':').last.trim();
      Utils.showSnackBar(context, errorMessage, 2000);
    }
  }

  void navigateToHomeScreen({UserCredential? response}) {
    if (_createAccount) _firebaseFirestoreHelper.setUserId(context, response!);
    Navigator.of(context).pushNamed(HomeScreen.routeName);
  }
}
