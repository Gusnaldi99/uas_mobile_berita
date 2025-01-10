import 'package:flutter/material.dart';
import 'package:uas_mobile_berita/models/bookmark_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkProvider extends ChangeNotifier {
  List<BookmarkNews> _bookmarkedNews = [];
  List<BookmarkNews> get bookmarkedNews => _bookmarkedNews;

  BookmarkProvider() {
    loadBookmarks();
  }

// mengelola data bookmark dari SharedPreferences(penyimpanan data lokal)
  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? bookmarksJson = prefs.getString('bookmarks');
    if (bookmarksJson != null) {
      final List<dynamic> decoded = jsonDecode(bookmarksJson);
      _bookmarkedNews =
          decoded.map((item) => BookmarkNews.fromMap(item)).toList();
      notifyListeners();
    }
  }

// menyimpan data bookmark ke SharedPreferences(penyimpanan data lokal)
  Future<void> saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData =
        jsonEncode(_bookmarkedNews.map((item) => item.toMap()).toList());
    await prefs.setString('bookmarks', encodedData);
  }

// mengecek apakah artikel yang dipilih sudah ditandai bookmark atau belum
  bool isBookmarked(String newsId) {
    return _bookmarkedNews.any((news) => news.id == newsId);
  }

// menambahkan atau menghapus berita dari bookmark screen, tergantung situasinya
  Future<void> toggleBookmark(BookmarkNews news) async {
    if (isBookmarked(news.id)) {
      _bookmarkedNews.removeWhere((item) => item.id == news.id);
    } else {
      _bookmarkedNews.add(news);
    }
    await saveBookmarks();
    notifyListeners();
  }
}
