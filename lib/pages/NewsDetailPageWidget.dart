/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: NewsDetailPageWidget.dart
 *  * Created on: 23.10.25, 19:23
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

import 'package:flutter/material.dart';
import 'package:smayl/backend/SmaylProfile.dart';

import '../utils/SmaylNews.dart';

class NewsDetailPageWidget extends StatelessWidget {
  final SmaylNews newsItem;
  final SmaylProfile author;
  final Widget avatar;

  const NewsDetailPageWidget({
    super.key,
    required this.newsItem,
    required this.avatar, required this.author,
  });

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(newsItem.timestamp);
    return Scaffold(
      appBar: AppBar(title: Text(newsItem.title)),
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
            Row(
              children: [
                Text('von ', style: const TextStyle(color: Colors.grey),),
                avatar,
                Text(
                  ' ${author.displayName} • '
                      '${date.day}.${date.month}.${date.year} um ${date.hour}:${date.minute} Uhr',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              newsItem.description,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
