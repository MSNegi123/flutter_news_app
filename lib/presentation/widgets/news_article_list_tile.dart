import 'package:cached_network_image/cached_network_image.dart';
import "../../utils/main_imports.dart";
import 'package:intl/intl.dart';

import '../../data/model/news_article_response_model.dart';
import '../../utils/utils.dart';
import '../screens/news_article_detail_screen.dart';

class NewsArticleListTile extends StatelessWidget {
  final NewsArticle newsArticleData;

  const NewsArticleListTile({super.key, required this.newsArticleData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(color: AppColors.strongWhite, borderRadius: BorderRadius.circular(12.r), boxShadow: [
        BoxShadow(
          offset: Offset(0, 0),
          blurRadius: 2,
          color: AppColors.mediumBlack,
          blurStyle: BlurStyle.outer,
        )
      ]),
      child: Hero(
        tag: newsArticleData.title,
        child: ListTile(
          tileColor: AppColors.strongWhite,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          contentPadding: EdgeInsets.zero,
          leading: SizedBox(
            height: 75.w,
            width: 75.w,
            child: CachedNetworkImage(
              imageUrl: newsArticleData.urlToImage,
              errorWidget: (context, url, obj) => CachedNetworkImage(
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQi069xQnEzvhenmSQoy04otHKzs75MUNLV3g&s",
                fit: BoxFit.fill,
              ),
              fit: BoxFit.fill,
            ),
          ),
          isThreeLine: false,
          titleAlignment: ListTileTitleAlignment.titleHeight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          title: Text(
            newsArticleData.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: AppColors.strongBlack, fontWeight: FontWeight.w500),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  newsArticleData.source.name,
                  style: TextStyle(color: AppColors.strongGrey, fontSize: 12.sp, fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.strongGrey,
                    size: 16.w,
                  ),
                  4.bw(),
                  Text(
                    formattedDateString(date: newsArticleData.publishedAt),
                    style: TextStyle(color: AppColors.strongGrey, fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsArticleDetailScreen(article: newsArticleData),
            ),
          ),
        ),
      ),
    );
  }
}
