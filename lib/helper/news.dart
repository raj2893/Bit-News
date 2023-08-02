import 'dart:convert';

import 'package:bitnews/model/ArticleModel.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=0c2ece9eb52b42309805ab5cb2cd8f39");

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              // publishedAt: element['publishedAt'],
              content: element['context']);

          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNews {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=0c2ece9eb52b42309805ab5cb2cd8f39");

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              // publishedAt: element['publishedAt'],
              content: element['context']);

          news.add(articleModel);
        }
      });
    }
  }
}
