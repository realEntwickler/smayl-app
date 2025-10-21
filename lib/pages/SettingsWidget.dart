/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: SettingsWidget.dart
 *  * Created on: 21.10.25, 12:11
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
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/ThemeProvider.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  bool _notify = true;

  List<Color> colors = <Color>[
    Colors.indigo,
    Colors.blue,
    Colors.pink,
    Colors.deepOrange,
    Colors.teal,
    Colors.redAccent
  ];

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

  Future<void> _saveNotifySetting(bool notifyValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("notify", notifyValue);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Einstellungen")),
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
          ),
          SizedBox(height: 12),
          Text("Primärfarbe auswählen"),
          SizedBox(height: 6),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: colors.map((color) {
              final isSelected = color == themeProvider.primaryColor;
              return GestureDetector(
                onTap: () => themeProvider.setPrimaryColor(color),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: isSelected ? Colors.black : Colors.transparent,
                          width: 3
                      )
                  ),
                )
              );
            }).toList(),
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.grey,
        padding: EdgeInsets.all(12),
        child: Text(
          '© ${DateTime
              .now()
              .year} Nils Kevin Körting-Eberhardt für HöV Rheinland-Pfalz • SMAYL 2.0',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ),
    );
  }
}
