/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: NewsProvider.dart
 *  * Created on: 24.10.25, 12:13
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

import 'package:http/http.dart' as http;
import 'package:smayl/interfaces/ISmaylNews.dart';

class NewsProvider {

  Future<ISmaylNews> getNewsById(String uniqueId) async {
    final response = await http.get(
        Uri.parse("http://127.0.0.1:8080/news/${uniqueId}"));

    if (response.statusCode == 200) {
      return ISmaylNews.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load user');
    }
  }
  
  Future<List<ISmaylNews>> getNews() async {
    final response = await http.get(Uri.parse("http://127.0.0.1:8080/news/get"));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      return jsonList
          .map((json) => ISmaylNews.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Fehler beim Laden der News: ${response.statusCode}');
    }
  }
}