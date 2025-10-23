/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: SettingsItem.dart
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
import 'package:smayl/provider/ThemeProvider.dart';

class SettingsItem extends StatelessWidget {

  final String title;
  final String subtitle;
  final Widget trailing;


  const SettingsItem(this.title, this.subtitle, this.trailing);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: themeProvider.themeData.textTheme.titleMedium ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4,),
                Text(
                  subtitle,
                  style: themeProvider.themeData.textTheme.bodySmall ?.copyWith(color: Colors.grey[600]),
                )
              ],
            ),
          ),
          trailing
        ],
      ),
    );
  }
}