/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: HomeWidget.dart
 *  * Last edited on: 21.10.25, 20:44
 *  *
 *  * This file is part of the project "SMAYL 2.0".
 *  *
 *  * Licensed under the Creative Commons Attribution - NonCommercial -
 *  * NoDerivatives 4.0 International License (CC BY-NC-ND 4.0).
 *  *
 *  * For more information about this license, please visit:
 *  * https://creativecommons.org/licenses/by-nc-nd/4.0/
 *
 */
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smayl/pages/ParkWidget.dart';
import 'package:smayl/pages/SettingsWidget.dart';
import 'package:smayl/pages/StartWidget.dart';
import 'package:smayl/pages/MenuWidget.dart';
import 'package:smayl/provider/ThemeProvider.dart';

import '../utils/NewsItem.dart';
import 'MySmaylWidget.dart';

class HomeWidget extends StatefulWidget {

  static late bool exclusiveBannerBehaviour;

  HomeWidget() {
    exclusiveBannerBehaviour = false;
  }

  @override
  State<StatefulWidget> createState() {
    return _HomeWidgetState();
  }
}

class _HomeWidgetState extends State<HomeWidget> {

  int pageIndex = 0;
  List<Widget> pages = [
    StartWidget(
      newsList: [
        NewsItem("Test News 1", "Test Beschreibung 1", "Nils Kevin Körting-Eberhardt", DateTime(2025, 10, 20, 8, 18)),
        NewsItem("Test News 2", "Test Beschreibung 2", "Bit Burger", DateTime(2025, 1, 01, 15, 30)),
        NewsItem("Test News 3", "Test Beschreibung 3", "Paul Ahner", DateTime(2025, 2, 09, 11, 44)),
      ],
    ),
    MenuWidget(),
    ParkWidget(),
    MySmaylWidget(),
    SettingsWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeData.scaffoldBackgroundColor,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Start", selectedIcon: Icon(Icons.home_outlined),),
          NavigationDestination(icon: Icon(Icons.menu), label: "Menü", selectedIcon: Icon(Icons.menu_open),),
          NavigationDestination(icon: Icon(Icons.local_parking), label: "Parken", selectedIcon: Icon(Icons.local_parking_outlined),),
          NavigationDestination(icon: Image.asset("assets/applogo.png", height: 30, width: 30,), label: "MySMAYL"),
          NavigationDestination(icon: Icon(Icons.settings_applications), label: "Einstellungen", selectedIcon: Icon(Icons.settings_applications_outlined),),
        ],
        indicatorColor: themeProvider.themeData.bottomNavigationBarTheme.selectedItemColor,
        selectedIndex: pageIndex,
      ),
      body: pages[pageIndex],
      appBar: AppBar(
        //title: Text("SMAYL 2.0"),
        flexibleSpace: Image.asset('assets/appbanner.png', fit: (HomeWidget.exclusiveBannerBehaviour ? BoxFit.fill : BoxFit.fitWidth),),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
    );
  }
}
