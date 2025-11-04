/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: MySmaylWidget.dart
 *  * Created on: 23.10.25, 19:23
 *  *
 *  * This file is part of the project "smayl-app".
 *  *
 *  * Licensed under the Creative Commons Attribution - NonCommercial -
 *  * NoDerivatives 4.0 International License (CC BY-NC-ND 4.0).
 *  *
 *  * For more information about this license, please visit:
 *  * https://creativecommons.org/licenses/by-nc-nd/4.0/
 *
 */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smayl/provider/ProfileProvider.dart';
import 'package:smayl/provider/ThemeProvider.dart';

enum AuthState { signIn, signUp, passwordReset, profile }

class MySmaylWidget extends StatefulWidget {
  const MySmaylWidget({super.key});

  @override
  State<StatefulWidget> createState() => _MySmaylWidgetState();
}

class _MySmaylWidgetState extends State<MySmaylWidget> {
  final _auth = FirebaseAuth.instance;
  AuthState _authState = AuthState.signIn;

  final emailEditController = TextEditingController();
  final passwordEditController = TextEditingController();
  final emailResetEditController = TextEditingController();

  bool _emailValid = true;
  bool _emailResetValid = true;
  bool _passwordValid = true;
  bool _passwordObscured = true;

  @override
  void initState() {
    super.initState();
    if (_auth.currentUser != null) {
      _auth.signOut();
    }
  }

  bool checkEmailInput(String value) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
    return regex.hasMatch(value);
  }

  void checkPasswordInput(String value) {
    _passwordValid = value.length >= 6;
  }

  void signInAction(ProfileProvider profileProvider) async {
    _auth
        .signInWithEmailAndPassword(
          email: emailEditController.text,
          password: passwordEditController.text,
        )
        .then((value) async {
          if (value.user != null) {
            final user = value.user!;
            print("logged in as: ${user.displayName}");
            var test = await profileProvider.loadProfile(user);
            setState(() {
              _authState = AuthState.profile;
            });
          } else {
            print('error');
          }
        })
        .onError((error, stackTrace) {
          setState(() {
            _emailValid = false;
            _passwordValid = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Beim Anmelden ist folgender Fehler aufgetreten: ${error.toString()}",
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    if (_authState == AuthState.signIn) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "MySMAYL - Anmeldung",
            style: themeProvider.themeData.appBarTheme.titleTextStyle,
          ),
          centerTitle: false,
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                label: Text("E-Mail Adresse"),
                icon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _emailValid ? Colors.grey : Colors.red,
                  ),
                ),
                errorText: _emailValid
                    ? null
                    : "Bitte gib eine gültige E-Mail Adresse an.",
              ),
              onChanged: (value) => setState(() {
                _emailValid = checkEmailInput(value);
              }),
              onSubmitted: (value) => signInAction(profileProvider),
              controller: emailEditController,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                label: Text("Passwort"),
                icon: Icon(Icons.password),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _passwordValid ? Colors.grey : Colors.red,
                  ),
                ),
                errorText: _passwordValid
                    ? null
                    : "Das eingegebene Passwort ist ungültig.",
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordObscured
                        ? Icons.visibility_off_outlined
                        : Icons.visibility,
                  ),
                  color: themeProvider.primaryColor,
                  onPressed: () => setState(() {
                    _passwordObscured = !_passwordObscured;
                  }),
                ),
              ),
              obscureText: _passwordObscured,
              onChanged: (value) => setState(() {
                checkPasswordInput(value);
              }),
              onSubmitted: (value) => signInAction(profileProvider),
              controller: passwordEditController,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                MaterialButton(
                  onPressed: () {
                    _emailValid = checkEmailInput(emailEditController.text);
                    checkPasswordInput(passwordEditController.text);

                    if (_emailValid && _passwordValid) {
                      signInAction(profileProvider);
                    } else {
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Bitte überprüfe deine angegebene E-Mail Adresse und/oder das Passwort.",
                          ),
                        ),
                      );
                    }
                  },
                  color: themeProvider.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.login, color: Colors.white),
                ),
                SizedBox(width: 12),
                MaterialButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState2) => AlertDialog(
                            title: Text("Passwort zurücksetzen"),
                            icon: Icon(Icons.help),
                            content: Column(
                              children: [
                                const Text(
                                  'Gib deine E-Mail-Adresse ein. Du erhältst anschließend eine E-Mail mit einem Link zum Zurücksetzen deines Passworts.',
                                ),
                                const SizedBox(height: 12),
                                TextField(
                                  controller: emailResetEditController,
                                  decoration: InputDecoration(
                                    labelText: 'E-Mail-Adresse',
                                    prefixIcon: Icon(Icons.email),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: _emailResetValid
                                            ? Colors.grey
                                            : Colors.red,
                                      ),
                                    ),
                                  ),
                                  onSubmitted: (value) {
                                    _emailResetValid = checkEmailInput(value);

                                    if (_emailResetValid) {
                                      _auth
                                          .sendPasswordResetEmail(email: value)
                                          .then((value) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Sollte ein Account mit dieser E-Mail existieren, erhältst du in den nächsten Minuten eine E-Mail zum Zurücksetzen deines Passwortes.",
                                                ),
                                              ),
                                            );
                                          });
                                    }
                                  },
                                  onChanged: (value) => setState2(() {
                                    _emailResetValid = checkEmailInput(value);
                                  }),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  color: themeProvider.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Passwort vergessen?",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 12),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      _authState = AuthState.signUp;
                    });
                  },
                  color: themeProvider.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Account erstellen",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (_authState == AuthState.profile) {
      return Scaffold(
        body: Column(
          children: [
            MaterialButton(
              onPressed: () {
                _auth.signOut();
                profileProvider.setProfile(null);
                setState(() {
                  _authState = AuthState.signIn;
                });
              },
              color: themeProvider.primaryColor,
              child: Icon(Icons.logout),
            ),
            Text("Hallo, ${profileProvider.currentProfile!.displayName}")
          ],
        ),
      );
    } else {
      return Text("${_authState.name}");
    }
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("MySMAYL"),
    //   ),
    //   body: AuthGateWidget(),
    // );
    //return AuthGateWidget();
  }
}
