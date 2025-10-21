/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: NewsWidget.dart
 *  * Last edited on: 21.10.25, 21:44
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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smayl/provider/ThemeProvider.dart';

import '../utils/NewsItem.dart';
import 'NewsDetailPageWidget.dart';

class NewsWidget extends StatelessWidget {

  final List<NewsItem> newsList;

  const NewsWidget({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Neuigkeiten"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final NewsItem newsItem = newsList[index];
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(newsItem.title, style: themeProvider.themeData.textTheme.titleLarge),
                  subtitle: Text(newsItem.description, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailPageWidget(newsItem: newsItem)));
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Color generateRandomColor(double opacity) {
    Random random = Random();
    return Color.fromRGBO(
        random.nextInt(255), random.nextInt(255), random.nextInt(255), opacity);
  }

}
