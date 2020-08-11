class News {
  String status;
  int totalResults;
  List<Article> articles;

  News({this.status, this.totalResults, this.articles});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: parsedArticles(json['articles']),
    );
  }

  static List<Article> parsedArticles(articlesJson) {
    var list = articlesJson['articles'] as List;
    List<Article> articlesList =
        list.map((data) => Article.fromJson(data)).toList();
    return articlesList;
  }
}

class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Article.fromJson(Map<String, dynamic> parsedJson) {
    return Article(
        source: Source.fromJson(parsedJson['source']),
        author: parsedJson['author'],
        title: parsedJson['title'],
        description: parsedJson['description'],
        url: parsedJson['url'],
        urlToImage: parsedJson['urlToImage'],
        publishedAt: parsedJson['publishedAt'],
        content: parsedJson['content']);
  }
}

class Source {
  String id;
  String name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json['id'], name: json['name']);
  }
}
