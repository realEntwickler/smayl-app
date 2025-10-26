/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: SmaylNews.dart
 *  * Created on: 26.10.25, 08:45
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
class SmaylNews {

  final String _id;
  final String title, description, authorId;
  final int timestamp;

  SmaylNews(this._id, this.title, this.description, this.authorId,
      this.timestamp);

  SmaylNews.fromJSON(Map<String, dynamic> json):
      _id = json['_id'],
      title = json['title'],
      description = json['description'],
      authorId = json['authorId'],
      timestamp = json['timestamp'];
}