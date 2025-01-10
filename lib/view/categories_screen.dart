import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uas_mobile_berita/models/categories_new_model.dart';
import 'package:uas_mobile_berita/view/setting_screen.dart';
import 'package:uas_mobile_berita/view_model/news_view_model.dart';
import 'package:uas_mobile_berita/view/news_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');
  String categoryName = 'General';
  final TextEditingController _searchController = TextEditingController();
  List<Articles>? _filteredArticles;
  List<Articles>? _allArticles;
  bool _isLoading = false;

  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    setState(() => _isLoading = true);
    try {
      final newsData = await newsViewModel.fetchCategoriesNewsApi(categoryName);
      setState(() {
        _allArticles = newsData.articles;
        _filteredArticles = _allArticles;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _filterArticles(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredArticles = _allArticles;
      });
      return;
    }

    setState(() {
      _filteredArticles = _allArticles?.where((article) {
        final titleLower = article.title?.toLowerCase() ?? '';
        final descriptionLower = article.description?.toLowerCase() ?? '';
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            descriptionLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 17, 0),
        title: Text(
          "Headline Hub",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        // Buatkan setting screen lalu buat icon diappbar arahkan ke setting screen
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.white,
            iconSize: 25,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle:
                          GoogleFonts.poppins(fontStyle: FontStyle.italic),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 17, 0),
                        ),
                      ),
                    ),
                    onChanged: _filterArticles,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 17, 0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.category,
                      color: Colors.white,
                    ),
                    onSelected: (String value) {
                      setState(() {
                        categoryName = value;
                        _searchController.clear();
                        _loadArticles();
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return categoriesList.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 12,
                                color: categoryName == choice
                                    ? const Color.fromARGB(255, 255, 17, 0)
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(choice, style: GoogleFonts.poppins()),
                            ],
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 17, 0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                categoryName,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  )
                : _filteredArticles == null || _filteredArticles!.isEmpty
                    ? Center(
                        child: Text(
                          'Mohon maaf artikel tidak ditemukan.',
                          style: GoogleFonts.poppins(),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: _filteredArticles!.length,
                        itemBuilder: (context, index) {
                          final article = _filteredArticles![index];
                          DateTime dateTime = DateTime.parse(
                            article.publishedAt.toString(),
                          );
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetailScreen(
                                      newsTitle: article.title ?? '',
                                      newImage: article.urlToImage ?? '',
                                      newsDate: article.publishedAt ?? '',
                                      author: article.author ?? '',
                                      desc: article.description ?? '',
                                      content: article.content ?? '',
                                      source: article.source?.name ?? '',
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              article.urlToImage.toString(),
                                          fit: BoxFit.cover,
                                          height: 80,
                                          width: 80,
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: SpinKitCircle(
                                              size: 30,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              article.title!,
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              article.source!.name.toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  size: 12,
                                                  color: Colors.grey[600],
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  format.format(dateTime),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                const Spacer(),
                                                // IconButton(
                                                //   onPressed: () {},
                                                //   icon: const Icon(
                                                //     Icons.bookmark_border,
                                                //     size: 20,
                                                //   ),
                                                //   padding: EdgeInsets.zero,
                                                //   constraints:
                                                //       const BoxConstraints(),
                                                //   color: Colors.blue,
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
