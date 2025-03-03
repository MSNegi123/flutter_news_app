import 'package:cached_network_image/cached_network_image.dart';

import "../../utils/main_imports.dart";
import '../../data/model/news_article_response_model.dart';
import '../../utils/utils.dart';
import '../widgets/custom_appbar.dart';

class NewsArticleDetailScreen extends StatelessWidget {
  final NewsArticle article;

  const NewsArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.strongWhite,
      appBar: CustomAppbar(title: article.source.name, showBackButton: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300.h,
                width: double.maxFinite,
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage,
                  errorWidget: (context, url, obj) => CachedNetworkImage(
                    imageUrl:
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQi069xQnEzvhenmSQoy04otHKzs75MUNLV3g&s",
                    fit: BoxFit.fill,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person, color: AppColors.strongGrey, size: 20.h),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w, right: 12.w),
                      child: Text(article.author, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
                    ),
                    Icon(Icons.watch_later_outlined, color: AppColors.strongGrey, size: 20.h),
                    4.bw(),
                    Text(
                      formattedDateString(date: article.publishedAt),
                      style: TextStyle(color: AppColors.strongGrey, fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Text(
                article.title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              10.bh(),
              Text(
                article.description,
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
