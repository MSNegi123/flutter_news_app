import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/data/model/news_article_response_model.dart';
import 'package:flutter_news_app/networking/repository/news_article_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'news_article_event.dart';
part 'news_article_state.dart';

class NewsArticleBloc extends Bloc<NewsArticleEvent, NewsArticleState> {
  final NewsArticleRepository newsRepository;
  final List<NewsArticle> articles = [];
  String query = '';
  int page = 1;
  bool isNext = true;
  List<String> recentSearches = [];

  NewsArticleBloc(this.newsRepository) : super(NewsInitial()) {
    _loadRecentSearches();
    on<SearchNews>((event, emit) {
      query = event.query;
      page = 1;
      articles.clear();
      add(FetchSearchedNews());
    });
    on<FetchAllNews>((event, emit) async {
      if (state is NewsLoading) return;
      emit(NewsLoading(articles));
      try {
        final newArticles = await newsRepository.fetchNews(query: 'latest', page: page);
        articles.addAll(newArticles);
        page++;
        emit(NewsLoaded(articles: articles));
      } catch (e) {
        emit(NewsError('Failed to load news. Check your connection.'));
      }
    });
    on<FetchSearchedNews>((event, emit) async {
      if (state is NewsLoading) return;
      emit(NewsLoading(articles));
      try {
        final newArticles = await newsRepository.fetchNews(query: query, page: page);
        articles.addAll(newArticles);
        page++;
        emit(NewsLoaded(articles: articles));
      } catch (e) {
        emit(NewsError('Failed to load news. Check your connection.'));
      }
    });
    on<LoadMoreNews>((event, emit) async {
      if (state is NewsLoading) return;
      if (page == 1) {
        emit(NewsLoading(articles));
      } else {
        emit(NewsLoaded(articles: articles, hasPage1Data: true));
      }
      try {
        final newArticles = await newsRepository.fetchNews(query: query.isEmpty ? "latest" : query, page: page);
        if (newArticles.isNotEmpty) {
          articles.addAll(newArticles);
          page++;
        } else {
          isNext = false;
        }
        emit(NewsLoaded(articles: articles));
      } catch (e) {
        emit(NewsError('Failed to load more news. Check your connection.'));
      }
    });
    on<SaveSearchQuery>((event, emit) async {
      if (!recentSearches.contains(event.query)) {
        recentSearches.insert(0, event.query);
        if (recentSearches.length > 5) {
          recentSearches = recentSearches.sublist(0, 5);
        }
        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList('_recentSearchesList', recentSearches);
        emit(RecentSearchesState(recentSearches));
      }
    });
    on<UpdateSearchQuery>((event, emit) {
      emit(RecentSearchesState(recentSearches));
    });
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    recentSearches = prefs.getStringList('_recentSearchesList') ?? [];
    if (recentSearches.isNotEmpty) {
      add(UpdateSearchQuery(''));
    }
  }
}
