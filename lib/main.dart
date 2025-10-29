/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: main.dart
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

import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fbui_auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smayl/pages/HomeWidget.dart';
import 'package:smayl/provider/ThemeProvider.dart';
import 'package:smayl/firebase_options.dart';
import 'package:smayl/provider/UserProvider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  await themeProvider.loadColor();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await fb_auth.FirebaseAuth.instance.setLanguageCode("de");

  fbui_auth.FirebaseUIAuth.configureProviders([fbui_auth.EmailAuthProvider()]);

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => themeProvider),
            ChangeNotifierProvider(create: (_) => UserProvider())
          ],
        child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        theme: themeProvider.themeData,
        supportedLocales: [
          Locale("de")
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale("de"),
        home: HomeWidget());

  }
}