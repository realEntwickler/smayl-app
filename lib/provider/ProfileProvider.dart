/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: ProfileProvider.dart
 *  * Created on: 01.11.25, 10:52
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smayl/backend/SmaylProfileType.dart';
import 'package:smayl/services/ProfileService.dart';

import '../backend/SmaylProfile.dart';

class ProfileProvider extends ChangeNotifier {
  late SmaylProfile? _smaylProfile;

  void setProfile(SmaylProfile? value) {
    _smaylProfile = value;
    notifyListeners();
  }

  Future<bool> loadProfile(User user) async {
    final profile = await ProfileService.getProfileById(user.uid);
    if (profile != null) {
      print('PP_loadProfileByExistingUser: true');
      setProfile(profile);
      return Future.value(true);
    } else {
      final result =
          ProfileService.createProfileInBackend(
            user,
            "firstName",
            "lastName",
            "emailAddress",
            "24-V-05",
            SmaylProfileType.student,
            false,
          ).then((value) {
            setProfile(value);
          });
      return Future.value(true);
    }
  }

  SmaylProfile? get currentProfile => _smaylProfile;
}
