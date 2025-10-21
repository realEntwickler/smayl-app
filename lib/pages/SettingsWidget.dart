/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: SettingsWidget.dart
 *  * Created on: 21.10.25, 14:35
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

  final colors = {
    "Indigo": Colors.indigo,
    "Blau": Colors.blue,
    "Standard": Colors.pink,
    "Orange": Colors.deepOrange,
    "Lila": Colors.purple,
    "Türkis": Colors.teal
  };
  
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
    String currentColorName = colors.entries.firstWhere((element) => element.value == themeProvider.primaryColor, orElse: () => const MapEntry('Standard', Colors.pink),).key;
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
          DropdownMenu<String>(
            initialSelection: currentColorName,
            width: 250,
            label: Text("Farbe auswählen"),
            leadingIcon: Icon(Icons.color_lens),
            onSelected: (String? value) {
              if (value != null) {
                final color = colors[value]!;
                setState(() => currentColorName = value);
                themeProvider.setPrimaryColor(color);
              }
            },
            dropdownMenuEntries: colors.entries.map((e) {
              return DropdownMenuEntry<String>(
                value: e.key,
                label: e.key,
                leadingIcon: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: e.value,
                    shape: BoxShape.circle
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
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
