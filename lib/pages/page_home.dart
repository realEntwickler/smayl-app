/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: page_home.dart
 *  * Created on: 19.10.25, 09:59
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

class page_home extends StatelessWidget {
  const page_home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      bottomNavigationBar: NavigationBar(destinations: [
        NavigationDestination(label: "Startseite", icon: Icon(Icons.home), enabled: true, selectedIcon: Icon(Icons.home_outlined),),
        NavigationDestination(label: "Menü", icon: Icon(Icons.menu), selectedIcon: Icon(Icons.menu_outlined),),
        NavigationDestination(label: "Parken", icon: Icon(Icons.local_parking), selectedIcon: Icon(Icons.local_parking_outlined),),
        NavigationDestination(label: "Einstellungen", icon: Icon(Icons.settings_applications), selectedIcon: Icon(Icons.settings_applications_outlined),),],
        backgroundColor: Colors.pink,),
    );
  }
}
