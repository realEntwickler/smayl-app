/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: SmaylProfile.dart
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

import 'SmaylProfileType.dart';

class SmaylProfile {
  final String _id;
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String displayName;
  final String licensePlate;
  final String studyGroup;
  final SmaylProfileType profileType;
  final bool administrative;
  final int timestamp;

  SmaylProfile(
    this._id,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.displayName,
    this.licensePlate,
    this.studyGroup,
    this.profileType,
    this.administrative,
    this.timestamp,
  );

  SmaylProfile.fromJson(Map<String, dynamic> json)
    : _id = json['_id'],
      firstName = json['firstName'],
      lastName = json['lastName'],
      emailAddress = json['emailAddress'],
      displayName = json['displayName'],
      licensePlate = json['licensePlate'],
      studyGroup = json['studyGroup'],
      profileType = json['profileType'],
      administrative = json['administrative'],
      timestamp = json['timestamp'];
}