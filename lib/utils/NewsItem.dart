/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: NewsItem.dart
 *  * Created on: 20.10.25, 14:47
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

class NewsItem {

  final String uniqueId;
  final String title;
  final String description;
  final String author;
  final DateTime date;

  NewsItem(this.uniqueId, this.title, this.description, this.author, this.date);
}