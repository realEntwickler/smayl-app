/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: UserProvider.dart
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
import 'package:smayl/utils/SmaylUser.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class UserProvider {

  List<SmaylUser> _registeredUsers = [SmaylUser(UuidV4().generate(), "koertini", "test", "Körting-Eberhardt, Nils", DateTime.now(), true)];

  void addUser(SmaylUser user) {
    _registeredUsers.add(user);
  }

  void removeUser(SmaylUser user) {
    _registeredUsers.remove(user);
  }

  SmaylUser getUserByUsername (String username) {
    return _registeredUsers.where((element) => element.username.toLowerCase() == username).first;
  }
}