/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: HomeWidget.dart
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smayl/pages/ParkWidget.dart';
import 'package:smayl/pages/SettingsWidget.dart';
import 'package:smayl/pages/NewsWidget.dart';
import 'package:smayl/pages/MenuWidget.dart';
import 'package:smayl/provider/ThemeProvider.dart';

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
    NewsWidget(),
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
          NavigationDestination(
            icon: Icon(Icons.newspaper),
            label: "News",
            selectedIcon: Icon(Icons.newspaper_outlined),
          ),
          NavigationDestination(
            icon: Icon(Icons.menu),
            label: "Menü",
            selectedIcon: Icon(Icons.menu_open),
          ),
          NavigationDestination(
            icon: Icon(Icons.local_parking),
            label: "Parken",
            selectedIcon: Icon(Icons.local_parking_outlined),
          ),
          NavigationDestination(
            icon: Image.asset("assets/applogo.png", height: 30, width: 30),
            label: "MySMAYL",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_applications),
            label: "Einstellungen",
            selectedIcon: Icon(Icons.settings_applications_outlined),
          ),
        ],
        indicatorColor:
            themeProvider.themeData.bottomNavigationBarTheme.selectedItemColor,
        selectedIndex: pageIndex,
      ),
      body: pages[pageIndex],
      appBar: AppBar(
        //title: Text("SMAYL 2.0"),
        flexibleSpace: Image.asset(
          'assets/appbanner.png',
          fit: (HomeWidget.exclusiveBannerBehaviour
              ? BoxFit.fill
              : BoxFit.fitWidth),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
    );
  }
}
