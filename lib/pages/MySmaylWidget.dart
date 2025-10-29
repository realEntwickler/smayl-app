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

  @override
  void initState() {
    super.initState();
    if (_auth.currentUser != null) {
      setState(() {
        _authState = AuthState.profile;
      });
    }
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
            TextField(
              decoration: InputDecoration(
                label: Text("E-Mail Adresse"),
                icon: Icon(Icons.email),
              ),
              controller: emailEditController,
            ),
            TextField(
              decoration: InputDecoration(
                label: Text("Passwort"),
                icon: Icon(Icons.password),
              ),
              controller: passwordEditController,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                MaterialButton(
                  onPressed: () {
                    if (emailEditController.text.length > 1) {

                    } else {

                    }
                  },
                  color: themeProvider.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.login),
                ),
                SizedBox(width: 12),
                MaterialButton(
                  onPressed: () {},
                  color: themeProvider.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Text("Passwort vergessen?"),
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
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Text("Account erstellen"),
                )
              ],
            ),
          ],
        ),
      );
    } else {
      throw UnimplementedError("Test");
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
