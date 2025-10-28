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
import 'package:provider/provider.dart';
import 'package:smayl/provider/ThemeProvider.dart';

class MySmaylWidget extends StatefulWidget {

  const MySmaylWidget({super.key});

  @override
  State<StatefulWidget> createState() => _MySmaylWidgetState();
}

class _MySmaylWidgetState extends State<MySmaylWidget> {

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("MySMAYL"),
    //   ),
    //   body: AuthGateWidget(),
    // );
    return AuthGateWidget();
  }
}

class AuthGateWidget extends StatelessWidget {
  const AuthGateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.setLanguageCode("de");
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
            //User is not signed in
          if (!snapshot.hasData) {
            return SignInScreen(showPasswordVisibilityToggle: true,);
          }

          return Scaffold(
            appBar: AppBar(
              title: Text("Du bist eingeloggt! Hallo, ${snapshot.data!.displayName}"),
            ),
            body: Row(
              children: [
                Text("Ausloggen"),
                SizedBox(width: 6, height: 6,),
                MaterialButton(
                  color: Provider.of<ThemeProvider>(context).primaryColor,
                  child: Icon(Icons.logout),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  }
                ),
              ],
            ),
          );
        },);
  }
}
