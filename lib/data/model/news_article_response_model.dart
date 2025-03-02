class NewsArticlesResponseData {
  final bool status;
  final int totalResults;
  final List<NewsArticle> articles;

  NewsArticlesResponseData({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsArticlesResponseData.fromJson(Map<String, dynamic> json) => NewsArticlesResponseData(
    status: (json["status"] is String)? json["status"].trim().toLowerCase()=="ok": false,
    totalResults: json["totalResults"],
    articles: List<NewsArticle>.from(json["articles"].map((x) => NewsArticle.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class NewsArticle {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  NewsArticle({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) => NewsArticle(
    source: Source.fromJson(json["source"]),
    author: json["author"]??"",
    title: json["title"]??"",
    description: json["description"]??"",
    url: json["url"]??"",
    urlToImage: json["urlToImage"]??"",
    publishedAt: DateTime.parse(json["publishedAt"]),
    content: json["content"]??"",
  );

  Map<String, dynamic> toJson() => {
    "source": source.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt.toIso8601String(),
    "content": content,
  };
}

class Source {
  final String id;
  final String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"]??"",
    name: json["name"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}