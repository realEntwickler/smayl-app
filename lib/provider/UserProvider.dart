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
import 'dart:convert';

import 'package:smayl/utils/SmaylUser.dart';

import 'package:http/http.dart' as http;

class UserProvider {

  Future<SmaylUser> getUserByUsername (String username) async {
    final response = await http.get(Uri.parse("http://127.0.0.1:8080/users/find?username=${username}"));

    if (response.statusCode == 200) {
      return SmaylUser.fromJSON(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<SmaylUser> getUserByUniqueId (String uniqueId) async {
    final response = await http.get(Uri.parse("http://127.0.0.1:8080/users/find?id=${uniqueId}"));

    if (response.statusCode == 200) {
      return SmaylUser.fromJSON(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load user');
    }
  }
}