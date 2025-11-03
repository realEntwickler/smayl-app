/*
 *
 *  * (c) 2025 Nils Kevin Koerting-Eberhardt (realEntwickler)
 *  *
 *  * File: NewsWidget.dart
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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smayl/provider/ThemeProvider.dart';
import 'package:smayl/services/NewsService.dart';
import 'package:smayl/services/ProfileService.dart';

import 'NewsDetailPageWidget.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<StatefulWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final apiResponse = NewsProvider().getNews();
    return FutureBuilder(
      future: apiResponse,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text("SMAYL News"),
                  pinned: true,
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        setState(() {});
                      },
                      enableFeedback: true,
                      child: Icon(
                        Icons.refresh,
                        color: themeProvider.primaryColor,
                      ),
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final news = snapshot.data!.elementAt(index);
                    return FutureBuilder(
                      future: ProfileService.getDisplayNameById(news.authorId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }

                        final Widget avatar = CircleAvatar(
                          radius: 12,
                          child: Text(
                            snapshot.data![0],
                            style: TextStyle(
                              color: generateRandomColor(75),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                        DateTime date = DateTime.fromMillisecondsSinceEpoch(
                          news.timestamp,
                        );
                        return Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: ListTile(
                            title: Text(
                              news.title,
                              style:
                                  themeProvider.themeData.textTheme.titleMedium,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4),
                                Text(
                                  news.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    avatar,
                                    SizedBox(width: 6),
                                    Text(
                                      "${snapshot.data!} • ${date.day}.${date.month}.${date.year}",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => NewsDetailPageWidget(
                                    newsItem: news,
                                    avatar: avatar,
                                    author: snapshot.data!,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }, childCount: snapshot.data!.length),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Color generateRandomColor(double opacity) {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      opacity,
    );
  }
}
