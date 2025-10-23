/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: MySmaylWidget.dart
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
import 'package:smayl/provider/UserProvider.dart';

import '../utils/SmaylUser.dart';

class MySmaylWidget extends StatefulWidget {

  const MySmaylWidget({super.key});

  @override
  State<StatefulWidget> createState() => _MySmaylWidgetState();
}

class _MySmaylWidgetState extends State<MySmaylWidget> {

  @override
  Widget build(BuildContext context) {
    final apiResponse = UserProvider().getUserByUsername("n.koertingebe");

    return FutureBuilder<SmaylUser>(future: apiResponse, builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Scaffold(body: Text("Hallo ${snapshot.data!.displayName}", style: TextStyle(fontSize: 20),),);
      } else if (snapshot.hasError){
        return Text("Error: ${snapshot.error}");
      }
      return CircularProgressIndicator();
    },);
  }
}