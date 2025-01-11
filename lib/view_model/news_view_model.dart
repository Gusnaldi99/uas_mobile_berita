import 'dart:io';
import 'package:uas_mobile_berita/models/categories_new_model.dart';
import 'package:uas_mobile_berita/models/news_channel_headlines_model.dart';
import 'package:uas_mobile_berita/repository/news_repository.dart';

class NewsViewModel {
  final NewsRepository _newsRepository = NewsRepository();

  Future<NewsChannelHeadlinesModel> fetchNewChannelHeadlinesApi() async {
    try {
      return await _newsRepository.fetchNewChannelHeadlinesApi();
    } on SocketException {
      throw const SocketException('Tidak ada koneksi internet');
    } catch (e) {
      rethrow;
    }
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    try {
      return await _newsRepository.fetchCategoriesNewsApi(category);
    } on SocketException {
      throw const SocketException('Tidak ada koneksi internet');
    } catch (e) {
      rethrow;
    }
  }
}