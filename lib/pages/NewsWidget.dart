/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: NewsWidget.dart
 *  * Last edited on: 22.10.25, 21:59
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("SMAYL News", style: TextStyle(color: Colors.white),),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset("assets/news_pic.jpg", fit: BoxFit.scaleDown,),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                  )
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final news = newsList[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    title: Text(
                      news.title,
                      style: themeProvider.themeData.textTheme.titleMedium,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(news.description, maxLines: 2, overflow: TextOverflow.ellipsis,),
                        SizedBox(height: 6),
                        Text(
                          "${news.author} • ${news.date.day}.${news.date.month}.${news.date.year}",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => NewsDetailPageWidget(newsItem: news)));
                    },
                  ),
                );
              },
              childCount: newsList.length)
          )
        ],
      ),
    );
  }

  Color generateRandomColor(double opacity) {
    Random random = Random();
    return Color.fromRGBO(
        random.nextInt(255), random.nextInt(255), random.nextInt(255), opacity);
  }

}
