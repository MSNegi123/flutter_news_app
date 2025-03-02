import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import "../../utils/main_imports.dart";
import '../../presentation/widgets/news_article_list_tile.dart';
import '../blocs/news_article/news_article_bloc.dart';
import '../widgets/action_button.dart';
import '../widgets/custom_appbar.dart';

class NewsArticlesListScreen extends StatefulWidget {
  const NewsArticlesListScreen({super.key});

  @override
  State<NewsArticlesListScreen> createState() => _NewsArticlesListScreenState();
}

class _NewsArticlesListScreenState extends State<NewsArticlesListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
          context.read<NewsArticleBloc>().isNext) {
        context.read<NewsArticleBloc>().add(LoadMoreNews());
      }
    });
  }

  @override
  void dispose() {
    _searchController.clear();
    _searchController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.strongWhite,
      appBar: CustomAppbar(title: AppStrings.appName),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SearchBar(
                controller: _searchController,
                focusNode: _focusNode,
              ),
              _RecentSearches(
                controller: _searchController,
                focusNode: _focusNode,
              ),
              Expanded(
                child: _NewsArticlesList(scrollController: _scrollController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  const _SearchBar({
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  Timer? _debounceTimer;
  String _lastSearchedText = "";

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearch(String query) {
    if (query.isNotEmpty) {
      context.read<NewsArticleBloc>().add(SaveSearchQuery(query));
      context.read<NewsArticleBloc>().add(SearchNews(query));
    } else {
      context.read<NewsArticleBloc>().add(FetchAllNews());
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        hintText: AppStrings.searchBarHintText,
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ActionButton(
                iconData: Icons.search,
                margin: EdgeInsets.only(right: 6.w),
                onPressed: () {
                  _onSearch(widget.controller.text.trim());
                },
              ),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: widget.controller,
                builder: (context, textEditingValue, child) {
                  bool shouldHideClearButton = false;
                  if (_lastSearchedText.isEmpty || textEditingValue.text.isEmpty) {
                    shouldHideClearButton = true;
                  }
                  _lastSearchedText = textEditingValue.text.trim();
                  return !shouldHideClearButton
                      ? ActionButton(
                          iconData: Icons.clear,
                          margin: EdgeInsets.only(left: 3.w, right: 6.w),
                          onPressed: () {
                            widget.controller.clear();
                            _lastSearchedText = "";
                            widget.focusNode.unfocus();
                            context.read<NewsArticleBloc>().add(FetchAllNews());
                          },
                        )
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onChanged: (query) {
        if (_debounceTimer?.isActive ?? false) {
          _debounceTimer?.cancel();
        }
        context.read<NewsArticleBloc>().add(UpdateSearchQuery(query));
        _debounceTimer = Timer(const Duration(seconds: 1), () {
          if (query.isEmpty) {
            widget.controller.clear();
            context.read<NewsArticleBloc>().add(FetchAllNews());
          } else if (query.length > 3) {
            context.read<NewsArticleBloc>().add(SaveSearchQuery(query));
            context.read<NewsArticleBloc>().add(SearchNews(query));
          }
        });
      },
      onSubmitted: _onSearch,
    );
  }
}

class _RecentSearches extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const _RecentSearches({required this.controller, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsArticleBloc, NewsArticleState>(
      builder: (context, state) {
        if (state is RecentSearchesState) {
          final filteredSearches = state.recentSearches
              .where((item) => item.toLowerCase().startsWith(controller.text.trim().toLowerCase()))
              .toList();
          if (filteredSearches.isNotEmpty && controller.text.length >= 3) {
            return _SearchHistoryList(
              searches: filteredSearches,
              title: AppStrings.matchingSearches,
            );
          } else if (state.recentSearches.isNotEmpty) {
            return _SearchHistoryList(
              searches: state.recentSearches,
              title: AppStrings.recentSearches,
            );
          }
        }
        return 12.bh();
      },
    );
  }
}

class _SearchHistoryList extends StatelessWidget {
  final String title;
  final List<String> searches;

  const _SearchHistoryList({
    required this.searches,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 25.h, bottom: 15.h),
          child: Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: searches
              .map((query) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: ActionChip(
                      label: Text(query),
                      onPressed: () {
                        context.read<NewsArticleBloc>().add(SearchNews(query));
                      },
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _NewsArticlesList extends StatelessWidget {
  const _NewsArticlesList({
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsArticleBloc, NewsArticleState>(
      builder: (context, state) {
        if (state is NewsLoading && state.articles.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NewsError) {
          return Center(child: Text(state.message));
        } else if (state is NewsLoaded) {
          if (state.articles.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, size: 50, color: AppColors.strongGrey),
                  10.bh(),
                  Text(AppStrings.irrelevantSearchText, style: TextStyle(color: AppColors.strongGrey)),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    controller: scrollController,
                    itemCount: state.articles.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      if (index < state.articles.length) {
                        final article = state.articles[index];
                        return NewsArticleListTile(newsArticleData: article);
                      } else {
                        return state is NewsLoading
                            ? const Center(child: CircularProgressIndicator())
                            : const SizedBox();
                      }
                    },
                    separatorBuilder: (_, __) => 10.bh(),
                  ),
                ),
                state.hasPage1Data
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: const Center(child: CircularProgressIndicator()),
                      )
                    : const SizedBox.shrink(),
              ],
            );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
