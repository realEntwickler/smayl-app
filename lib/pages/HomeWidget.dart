/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: HomeWidget.dart
 *  * Created on: 20.10.25, 11:50
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
import 'package:flutter/material.dart';
import 'package:smayl/pages/ParkWidget.dart';
import 'package:smayl/pages/SettingsWidget.dart';
import 'package:smayl/pages/StartWidget.dart';
import 'package:smayl/pages/MenuWidget.dart';

import '../utils/NewsItem.dart';

class HomeWidget extends StatefulWidget {

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
        NewsItem("Parkplatzproblem", "Die Hochschule weiß über das Parkplatz-Problem Bescheid und bemüht sich um eine nahe Lösung. Wir bitten daher um Verständnis.", DateTime(2025, 10, 20)),
        NewsItem("Titel Test", "Beschreibung Test", DateTime(2025, 1, 11))
      ],
    ),
    MenuWidget(),
    ParkWidget(),
    SettingsWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.bottomNavigationBarTheme.backgroundColor,
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
          NavigationDestination(icon: Icon(Icons.settings_applications), label: "Einstellungen", selectedIcon: Icon(Icons.settings_applications_outlined),),
        ],
        indicatorColor: themeData.bottomNavigationBarTheme.selectedItemColor,
        selectedIndex: pageIndex,
      ),
      body: pages[pageIndex],
      appBar: AppBar(
        //title: Text("SMAYL 2.0"),
        flexibleSpace: Image.asset('assets/appbanner.png', fit: BoxFit.fill,),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
    );
  }
}
