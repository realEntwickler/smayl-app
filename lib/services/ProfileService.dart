/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: ProfileService.dart
 *  * Created on: 01.11.25, 10:57
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:smayl/backend/SmaylProfile.dart';
import 'package:smayl/backend/SmaylProfileType.dart';

class ProfileService {

  static Future<String> getDisplayNameById (String id) async {
    final backendResponse = await get(Uri.parse("http://127.0.0.1:8080/profile/getdisplayname?id=${id}"));

    return Future.value(backendResponse.body);
  }

  static Future<SmaylProfile?> getProfileById (String id) async {
    final backendResponse = await get(Uri.parse("http://127.0.0.1:8080/profile/${id}"));

    print('PS_getProfileById: ${backendResponse.body}');
    print('PS_getProfileById: ${backendResponse.statusCode}');

    if (backendResponse.statusCode == 200) {
      return SmaylProfile.fromJson(jsonDecode(backendResponse.body) as Map<String, dynamic>);
    } else if (backendResponse.statusCode == 404){
      return null;
    } else {
      throw Exception("The backend response (${backendResponse.statusCode} was: ${backendResponse.body}");
    }
  }
  
  static Future<SmaylProfile> createProfileInBackend(User user, String firstName, String lastName, String emailAddress, String studyGroup, SmaylProfileType profileType, bool administrative) async {
    print(user.uid);
    final profile = SmaylProfile(user.uid, firstName, lastName, emailAddress, "$lastName, $firstName", "", studyGroup, profileType, administrative, DateTime.timestamp().millisecondsSinceEpoch);
    print(profile.id);
    final response = await post(Uri.parse("http://127.0.0.1:8080/profile/create"), headers: {"Content-Type": "application/json"}, body: jsonEncode(profile.toJson()));
    print('PS_createProfileBackend: ${response.body}');
    if (response.statusCode == 201) {
      return Future.value(SmaylProfile.fromJson(jsonDecode(response.body)));
    } else {
      return Future.value(null);
    }
  }
}