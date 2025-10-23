/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: SmaylUser.dart
 *  * Created on: 23.10.25, 12:30
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
import 'dart:ffi';

import 'package:uuid/v4.dart';

class SmaylUser {

  final String _uniqueId;
  final String _username;
  final String _password;
  final String _displayName;
  final DateTime _timestamp;
  final bool _enhancedPriviliges;

  SmaylUser(this._uniqueId, this._username, this._password, this._displayName,
      this._timestamp, this._enhancedPriviliges);

  bool get enhancedPriviliges => _enhancedPriviliges;

  DateTime get timestamp => _timestamp;

  String get displayName => _displayName;

  String get password => _password;

  String get username => _username;

  String get uniqueId => _uniqueId;


}