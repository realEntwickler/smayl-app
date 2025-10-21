/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: SettingsWidget.dart
 *  * Created on: 21.10.25, 20:16
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
import 'package:url_launcher/url_launcher.dart';

import '../provider/ThemeProvider.dart';
import '../utils/SettingsItem.dart';

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
    "Türkis": Colors.teal,
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
    String currentColorName = colors.entries
        .firstWhere(
          (element) => element.value == themeProvider.primaryColor,
          orElse: () => const MapEntry('Standard', Colors.pink),
        )
        .key;
    return Scaffold(
      appBar: AppBar(title: Text("Einstellungen")),
      body: ListView(
        children: [
          SettingsItem(
            "Benachrichtigungen",
            "Möchtest du Push-Benachrichtigungen erhalten?",
            Switch(
              value: _notify,
              onChanged: (value) {
                setState(() {
                  _notify = value;
                });
              },
            ),
          ),
          Divider(height: 1),
          SettingsItem(
            "Primärfarbe",
            "Bestimmt die Hauptfarbe der App",
            DropdownMenu<String>(
              initialSelection: currentColorName,
              width: 250,
              label: Text("Farbe auswählen"),
              leadingIcon: Icon(
                Icons.color_lens,
                color: themeProvider.primaryColor,
              ),
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
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Divider(height: 1),
          SettingsItem("Datenschutz & Impressum", "Hier findest du Hinweise zur Datenverarbeitung und zum Herausgeber dieser App.", MaterialButton(
            child: Text("Hinweise öffnen"),
            onPressed: () {
              var uri = Uri.parse("https://hoev.rlp.de/ueber-uns/impressum");
              _launchUrl(uri);
            }
          ))
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.grey,
        padding: EdgeInsets.all(12),
        child: Text(
          '© ${DateTime.now().year} Nils Kevin Körting-Eberhardt für HöV Rheinland-Pfalz • SMAYL 2.0',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri uri) async {
    if (! await launchUrl(uri)) {
      throw Exception("$uri konnte nicht aufgerufen werden.");
    }
  }
}
