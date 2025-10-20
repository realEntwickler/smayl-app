/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: HomeWidget.dart
 *  * Created on: 20.10.25, 08:34
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

class HomeWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeWidgetState();
  }
}

class _HomeWidgetState extends State<HomeWidget> {

  int pageIndex = 0;
  List<Widget> pages = [
    StartWidget(),
    MenuWidget(),
    ParkWidget(),
    SettingsWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: Colors.pink,
        indicatorColor: Color.fromRGBO(30, 233, 164, 100),
        selectedIndex: pageIndex,
      ),
      body: pages[pageIndex],
    );
  }
}
