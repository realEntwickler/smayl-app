/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: ParkWidget.dart
 *  * Last edited on: 21.10.25, 09:45
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

class ParkWidget extends StatefulWidget {
  const ParkWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ParkWidgetState();
  }
}

class _ParkWidgetState extends State<ParkWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Parken am Campus Mayen")),
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Fahrzeug melden:"),
              SizedBox(height: 6),
              TextFormField(
                autocorrect: false,
                textAlign: TextAlign.center,
                decoration: InputDecoration(icon: Icon(Icons.label)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
