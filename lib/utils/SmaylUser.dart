/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: SmaylUser.dart
 *  * Created on: 23.10.25, 22:11
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

class SmaylUser {
  final int creationTimestamp;
  final String uniqueId;
  final String username;
  final String password;
  final String emailAddress;
  final String displayName;

  SmaylUser({required this.creationTimestamp, required this.uniqueId, required this.username, required this.password,
      required this.emailAddress, required this.displayName});

  factory SmaylUser.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {'creationTimestamp': int creationTimestamp, 'uniqueId': String uniqueId, 'username': String username, 'password': String password, 'emailAddress': String emailAddress, 'displayName': String displayName} => SmaylUser(
        creationTimestamp: creationTimestamp, uniqueId: uniqueId, username: username, password: password, emailAddress: emailAddress, displayName: displayName
      ),
    _ => throw FormatException('Failed to load user.')
    };
  }
}