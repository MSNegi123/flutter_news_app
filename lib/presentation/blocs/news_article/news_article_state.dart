part of "../news_article/news_article_bloc.dart";

abstract class NewsArticleState {}

class NewsInitial extends NewsArticleState {}

class NewsLoading extends NewsArticleState {
  final List<NewsArticle> articles;

  NewsLoading(this.articles);
}

class NewsLoaded extends NewsArticleState {
  final List<NewsArticle> articles;
  final bool hasPage1Data;

  NewsLoaded({required this.articles, this.hasPage1Data=false});
}

class NewsError extends NewsArticleState {
  final String message;

  NewsError(this.message);
}

class RecentSearchesState extends NewsArticleState {
  final List<String> recentSearches;

  RecentSearchesState(this.recentSearches);
}
