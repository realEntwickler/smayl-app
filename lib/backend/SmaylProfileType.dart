/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: SmaylProfileType.dart
 *  * Created on: 01.11.25, 09:47
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

enum SmaylProfileType {

  student("Student-/in"),
  lecturer("Dozent-/in"),
  administrative_staff("Verwaltungsmitarbeiter-/in");

  final String displayName;

  const SmaylProfileType(this.displayName);

  SmaylProfileType getTypeByString (String value) {
    return SmaylProfileType.values.byName(value);
  }
}