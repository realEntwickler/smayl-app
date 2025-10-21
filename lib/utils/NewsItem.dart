/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: NewsItem.dart
 *  * Last edited on: 21.10.25, 09:10
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

import 'package:uuid/v4.dart';

class NewsItem {

  late String uniqueId;
  final String title;
  final String description;
  final String author;
  final DateTime date;

  NewsItem(this.title, this.description, this.author, this.date) {
    uniqueId = UuidV4().generate().toString();
  }
}