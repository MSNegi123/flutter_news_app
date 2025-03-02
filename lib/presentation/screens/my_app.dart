import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/main_imports.dart';
import '../../presentation/screens/news_articles_list_screen.dart';
import '../../networking/repository/news_article_repository.dart';
import '../blocs/news_article/news_article_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NewsArticleRepository(),
      child: ScreenUtilInit(
        designSize: Size(360, 800),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0), devicePixelRatio: 1.0),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: BlocProvider(
              create: (context) => NewsArticleBloc(context.read<NewsArticleRepository>())..add(FetchAllNews()),
              child: NewsArticlesListScreen(),
            ),
          ),
        ),
      ),
    );
  }
}