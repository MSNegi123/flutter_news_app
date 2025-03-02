part of "news_article_bloc.dart";

abstract class NewsArticleEvent {}

class FetchAllNews extends NewsArticleEvent {}

class FetchSearchedNews extends NewsArticleEvent {}

class SearchNews extends NewsArticleEvent {
  final String query;

  SearchNews(this.query);
}

class SaveSearchQuery extends NewsArticleEvent {
  final String query;

  SaveSearchQuery(this.query);
}

class UpdateSearchQuery extends NewsArticleEvent {
  final String query;

  UpdateSearchQuery(this.query);
}

class LoadMoreNews extends NewsArticleEvent {}
