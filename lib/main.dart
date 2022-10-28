import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mynews/news_api.dart';
import 'package:mynews/models/article.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var articles = <Article>[];

  void _getArticles() {
    NewsApi.getArticles().then((response) {
      Iterable list = json.decode(response.body)['articles'];
      articles = list.map((model) => Article.fromJson(model)).toList();
    });
  }

  void _launchURL(String url) async {
    if (!await launchUrlString(url)) throw 'Could not launch $url';
  }

  @override
  void initState() {
    super.initState();
    _getArticles();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My News'),
        ),
        body: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                _launchURL(articles[index].url);
              },
              title: Text(articles[index].title),
              subtitle: Text(articles[index].source),
              leading: Container(
                height: 60,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(articles[index].urlToImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
