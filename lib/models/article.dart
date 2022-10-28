class Article {
  late String title;
  late String source;
  late String urlToImage;
  late String url;

  Article(this.title, this.source, this.urlToImage, this.url);

  Article.fromJson(Map json)
      : title = json['title'],
        source = json['source']['name'],
        urlToImage = json['urlToImage'],
        url = json['url'];
}
