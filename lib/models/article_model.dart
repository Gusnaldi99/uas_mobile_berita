class ArticleModel {
  final String title;
  final String? urlToImage;
  final String publishedAt;
  final String? author;
  final String? description;
  final String? content;
  final String sourceName;

  ArticleModel({
    required this.title,
    this.urlToImage,
    required this.publishedAt,
    this.author,
    this.description,
    this.content,
    required this.sourceName,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt,
        'author': author,
        'description': description,
        'content': content,
        'sourceName': sourceName,
      };

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        title: json['title'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'],
        author: json['author'],
        description: json['description'],
        content: json['content'],
        sourceName: json['sourceName'],
      );
}
