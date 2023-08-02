class ArticleModel {
  ArticleModel({
    this.author,
    this.title,
    this.url,
    this.description,
    this.content,
    this.urlToImage,
    // required this.publishedAt
  });
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;
  // DateTime publishedAt;
}
