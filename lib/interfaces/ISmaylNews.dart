/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: ISmaylNews.dart
 *  * Created on: 24.10.25, 12:05
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

class ISmaylNews {
  final String title;
  final String description;
  final String authorUniqueId;
  final int creationTimestamp;
  final String uniqueId;

  ISmaylNews({required this.title, required this.description, required this.authorUniqueId,
      required this.creationTimestamp, required this.uniqueId});

  factory ISmaylNews.fromJson(Map<String, dynamic> json) {
    return ISmaylNews(
      title: json['title'] as String,
      description: json['description'] as String,
      authorUniqueId: json['authorUniqueId'] as String,
      creationTimestamp: json['creationTimestamp'] as int,
      uniqueId: json['uniqueId'] as String,
    );
  }
}