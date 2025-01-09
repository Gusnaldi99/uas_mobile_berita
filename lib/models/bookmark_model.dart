class BookmarkNews {
  final String id;
  final String image;
  final String title;
  final String date;
  final String author;
  final String description;
  final String content;
  final String source;

  BookmarkNews({
    required this.id,
    required this.image,
    required this.title,
    required this.date,
    required this.author,
    required this.description,
    required this.content,
    required this.source,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'date': date,
      'author': author,
      'description': description,
      'content': content,
      'source': source,
    };
  }

  factory BookmarkNews.fromMap(Map<String, dynamic> map) {
    return BookmarkNews(
      id: map['id'],
      image: map['image'],
      title: map['title'],
      date: map['date'],
      author: map['author'],
      description: map['description'],
      content: map['content'],
      source: map['source'],
    );
  }
}
