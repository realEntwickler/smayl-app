/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: ThemeProvider.dart
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
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  Color _primaryColor = Colors.pink;
  
  Color get primaryColor => _primaryColor;
  
  ThemeData get themeData => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _primaryColor),
    useMaterial3: true,
  );

  void setPrimaryColor (Color color) {
    _primaryColor = color;
    notifyListeners();
    saveColor();
  }

  Future<void> loadColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt("primaryColor") ?? Colors.pink.toARGB32();
    _primaryColor = Color (colorValue);
    notifyListeners();
  }

  Future<void> saveColor() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("primaryColor", _primaryColor.toARGB32());
  }
}