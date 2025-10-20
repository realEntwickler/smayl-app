/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: StartWidget.dart
 *  * Created on: 20.10.25, 13:53
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

class StartWidget extends StatelessWidget {

  final List<NewsItem> newsList;

  const StartWidget({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final NewsItem newsItem = newsList[index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Text("NewsID: ${newsItem.uniqueId}"),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(newsItem.title, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 6),
                    Text(newsItem.description, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 6),
                    Text('${newsItem.date.day}.${newsItem.date.month}.${newsItem.date.year}', style: const TextStyle(color: Colors.grey))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

}