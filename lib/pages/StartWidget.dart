/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: StartWidget.dart
 *  * Last edited on: 21.10.25, 09:22
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
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          child:
                            Text(newsItem.author[0], style: TextStyle(color: generateRandomColor(75), fontSize: 12),),
                        ),
                        SizedBox(width: 6,),
                        Text('${newsItem.author} • ${newsItem.date.day}.${newsItem.date.month}.${newsItem.date.year} um ${newsItem.date.hour}:${newsItem.date.minute} Uhr', style: const TextStyle(color: Colors.grey))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Color generateRandomColor(double opacity) {
    Random random = Random();
    return Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), opacity);
  }

}