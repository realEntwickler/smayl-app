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

  final String _id;
  final String displayName;
  final String emailAddress;
  final String password;
  final String username;
  final int timestamp;
  final bool enhancedPriviliges;


  SmaylUser(this._id, this.displayName, this.emailAddress, this.password,
      this.username, this.timestamp, this.enhancedPriviliges);

  SmaylUser.fromJSON(Map<String, dynamic> json):
      _id = json["id"],
      displayName = json["displayName"],
      emailAddress = json["emailAddress"],
      password = json["password"],
      username = json["username"],
      timestamp = json["timestamp"],
      enhancedPriviliges = json["enhancedPriviliges"];

}