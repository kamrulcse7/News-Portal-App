import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_portal_app/model/news_model.dart';
import 'package:news_portal_app/widget/const.dart';

//https://newsapi.org/v2/everything?apiKey=267508c46aba4122b6dde617e7698d9c&q=tesla&from=2022-08-10&sortBy=publishedAt
class NewsApiService {
  // Future getNewsData() async {
  //   var link = Uri.https(baseUrl, "/v2/everything", {
  //     "q": "bitcoin",
  //   });
  //   var link2 = "https://newsapi.org/v2/everything?q=bitcoin&apiKey";
  //   print("sddddddddddddddddddddddddd");
  //   var responce =
  //       await http.get(Uri.parse(link2), headers: {"X-Api-Key": apiKey});

  //   print("responce isssssssssss${responce.body}");
  // }

  Future<List<Articles>> getNewsData({required int page, required String sortBy, required String searchText}) async {
    List<Articles> newsList = [];
    var endPointUrl = Uri.parse(
        "https://newsapi.org/v2/everything?apiKey=267508c46aba4122b6dde617e7698d9c&q=tesla&sortBy=$sortBy&page=$page&pageSize=5");

    var responce = await http.get(endPointUrl);
    var data = jsonDecode(responce.body);
    Articles articles;
    for(var i in data['articles']){
      articles = Articles.fromJson(i);
      newsList.add(articles);
    }
    return newsList;
  }
}
