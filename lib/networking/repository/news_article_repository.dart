import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/model/news_article_response_model.dart';

class NewsArticleRepository {
  final Dio _dio = Dio();
  final String _apiKey = dotenv.env["API_KEY"].toString();
  final String _baseUrl = dotenv.env["baseUrl"].toString()+dotenv.env["fetchNewsArticles"].toString();

  Future<List<NewsArticle>> fetchNews({required String query, required int page}) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {'q': query, 'apiKey': _apiKey, 'page': page, 'pageSize': 20},
      );
      var newsArticleResponseData = NewsArticlesResponseData.fromJson(response.data);
      if(newsArticleResponseData.status){
        return newsArticleResponseData.articles;
      } else {
        return [];
      }
    } catch (exception) {
      print("Error occurred while fetching news:$exception");
      return [];
    }
  }
}