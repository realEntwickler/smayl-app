/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: SettingsWidget.dart
 *  * Last edited on: 21.10.25, 09:10
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
import 'package:shared_preferences/shared_preferences.dart';

class SettingsWidget extends StatefulWidget {

  const SettingsWidget({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {

  bool _notify = true;

  @override
  void initState() {
    _loadSettings();
    super.initState();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notify = prefs.getBool("notify") ?? true;
    });
  }

  Future<void> _saveNotifySetting (bool notifyValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("notify", notifyValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Einstellungen"),),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text("Benachrichtigungen"),
            subtitle: Text("Möchtest du Push-Mittelungen erhalten?"),
            value: _notify,
            onChanged: (bool value) {
              setState(() {
                _notify = value;
              });
              _saveNotifySetting(value);
            },
            secondary: Icon(Icons.notifications),
          )
        ],
      ),
    );
  }

}