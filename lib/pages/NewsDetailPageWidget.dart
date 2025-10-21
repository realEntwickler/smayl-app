/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: NewsDetailPageWidget.dart
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

import 'package:flutter/material.dart';

import '../utils/NewsItem.dart';

class NewsDetailPageWidget extends StatelessWidget {

  final NewsItem newsItem;

  const NewsDetailPageWidget({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsItem.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              newsItem.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'von ${newsItem.author} • '
                  '${newsItem.date.day}.${newsItem.date.month}.${newsItem.date.year} um ${newsItem.date.hour}:${newsItem.date.minute} Uhr',
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(height: 24),
            Text(
              newsItem.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}