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
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smayl/provider/ThemeProvider.dart';

import '../provider/UserProvider.dart';

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

  bool _emailValid = true;
  bool _passwordValid = true;
  bool _passwordObscured = true;

  @override
  void initState() {
    super.initState();
    if (_auth.currentUser != null) {
      setState(() {
        _authState = AuthState.profile;
      });
    }
  }

  void checkEmailInput (String value){
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
    _emailValid = regex.hasMatch(value);
  }

  void checkPasswordInput (String value) {
    _passwordValid = value.length >= 6;
  }

  void signInAction() {
    _auth.signInWithEmailAndPassword(email: emailEditController.text, password: passwordEditController.text).then((value) {
      if (value.user != null) {
        final user = value.user!;
        print("logged in as: ${user.displayName}");
        setState(() {
          _authState = AuthState.profile;
        });
      } else {
        print('error');
      }
    }).onError((error, stackTrace) {
      print('error ${error.toString()}');
    },);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
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
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                label: Text("E-Mail Adresse"),
                icon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _emailValid ? Colors.grey : Colors.red,
                  ),
                ),
                errorText: _emailValid ? null : "Bitte gib eine gültige E-Mail Adresse an."
              ),
              onChanged: (value) => setState(() {
                checkEmailInput(value);
              }),
              onSubmitted: (value) => signInAction(),
              controller: emailEditController,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                label: Text("Passwort"),
                icon: Icon(Icons.password),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _passwordValid ? Colors.grey : Colors.red
                  )
                ),
                errorText: _passwordValid ? null : "Das eingegebene Passwort ist ungültig.",
                suffixIcon: IconButton(
                  icon: Icon(_passwordObscured ? Icons.visibility_off_outlined : Icons.visibility),
                  color: themeProvider.primaryColor,
                  onPressed: () => setState(() {
                    _passwordObscured = !_passwordObscured;
                  }),
                )
              ),
              obscureText: _passwordObscured,
              onChanged: (value) => setState(() {
                checkPasswordInput(value);
              }),
              onSubmitted: (value) => signInAction(),
              controller: passwordEditController,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      checkEmailInput(emailEditController.text);
                      checkPasswordInput(passwordEditController.text);

                      if (_emailValid && _passwordValid) {
                        signInAction();
                      } else {
                        print('Login failed');
                      }
                    });
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
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: Text("Passwort zurücksetzen"),
                        icon: Icon(Icons.help),
                        content: Column(
                          children: [
                            const Text(
                              'Gib deine E-Mail-Adresse ein. Du erhältst anschließend eine E-Mail mit einem Link zum Zurücksetzen deines Passworts.',
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: emailEditController,
                              decoration: const InputDecoration(
                                labelText: 'E-Mail-Adresse',
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                  },
                  color: themeProvider.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text("Passwort vergessen?", style: TextStyle(color: Colors.white)),
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
                  child: Text("Account erstellen", style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (_authState == AuthState.profile){
      return MaterialButton(onPressed: () {
        _auth.signOut();
        setState(() {
          _authState = AuthState.signIn;
        });
      },
      color: themeProvider.primaryColor,
      child: Icon(Icons.logout),);
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

class _LoginScreenState extends State<MySmaylWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class AuthGateWidget extends StatelessWidget {
  const AuthGateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //User is not signed in
        if (!snapshot.hasData) {
          return SignInScreen(showPasswordVisibilityToggle: true);
        }
        userProvider.setUser(snapshot.data!);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Du bist eingeloggt! Hallo, ${snapshot.data!.displayName}",
            ),
          ),
          body: Row(
            children: [
              Text("Ausloggen"),
              SizedBox(width: 6, height: 6),
              MaterialButton(
                color: Provider.of<ThemeProvider>(context).primaryColor,
                child: Icon(Icons.logout),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
