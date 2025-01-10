// import 'package:http/http.dart';
import 'package:uas_mobile_berita/models/categories_new_model.dart';
import 'package:uas_mobile_berita/models/news_channel_headlines_model.dart';
import 'package:uas_mobile_berita/repository/news_repository.dart';

class NewsViewModel {
  final _api = NewsRepository();

  Future<NewsChannelHeadlinesModel> fetchNewChannelHeadlinesApi() async {
    final response = await _api.fetchNewChannelHeadlinesApi();
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await _api.fetchCategoriesNewsApi(category);
    return response;
  }
}
