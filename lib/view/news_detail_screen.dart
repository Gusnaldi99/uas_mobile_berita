import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uas_mobile_berita/models/bookmark_model.dart';
import 'package:uas_mobile_berita/providers/bookmark_provider.dart';

class NewsDetailScreen extends StatefulWidget {
  final String newImage, newsTitle, newsDate, author, desc, content, source;

  const NewsDetailScreen({
    super.key,
    required this.newImage,
    required this.newsTitle,
    required this.newsDate,
    required this.author,
    required this.desc,
    required this.content,
    required this.source,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format = DateFormat('MMMM dd, yyyy');
  late BookmarkProvider bookmarkProvider;

  @override
  void initState() {
    super.initState();
    bookmarkProvider = Provider.of<BookmarkProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    DateTime dateTime = DateTime.tryParse(widget.newsDate) ?? DateTime.now();

    // Get the current theme
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // Use system background color
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        // Use system colors for AppBar
        backgroundColor: const Color.fromARGB(255, 255, 17, 0),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryTextTheme.titleLarge?.color,
        ),
        title: Text(
          "News Detail",
          style: GoogleFonts.poppins(
            color: Theme.of(context).primaryTextTheme.titleLarge?.color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: widget.newImage,
                    width: width,
                    height: height * 0.4,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error_outline,
                      color: Theme.of(context).colorScheme.error,
                      size: 50,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Text(
                    widget.newsTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.8),
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Consumer<BookmarkProvider>(
                    builder: (context, bookmarkProvider, child) {
                      final String newsId = widget.newsTitle;
                      final bool isBookmarked =
                          bookmarkProvider.isBookmarked(newsId);

                      return FloatingActionButton(
                        onPressed: () {
                          final news = BookmarkNews(
                            id: newsId,
                            image: widget.newImage,
                            title: widget.newsTitle,
                            date: widget.newsDate,
                            author: widget.author,
                            description: widget.desc,
                            content: widget.content,
                            source: widget.source,
                          );
                          bookmarkProvider.toggleBookmark(news);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isBookmarked
                                    ? 'Removed from bookmarks'
                                    : 'Added to bookmarks',
                                style: GoogleFonts.poppins(),
                              ),
                              backgroundColor:
                                  isBookmarked ? Colors.red : Colors.green,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_add_outlined,
                          color: Theme.of(context).primaryIconTheme.color,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Container(
              width: width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  if (!isDarkMode)
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.newsTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.source,
                              color: Theme.of(context).iconTheme.color,
                              size: 18),
                          const SizedBox(width: 5),
                          Text(
                            widget.source,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Theme.of(context).iconTheme.color,
                              size: 18),
                          const SizedBox(width: 5),
                          Text(
                            format.format(dateTime),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(color: Theme.of(context).dividerColor),
                  Row(
                    children: [
                      const Icon(Icons.description_outlined,
                          color: Colors.blue, size: 20),
                      const SizedBox(width: 10),
                      Text(
                        "Description",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.titleMedium?.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.desc,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                  Divider(color: Theme.of(context).dividerColor),
                  if (widget.content.isNotEmpty) ...[
                    Row(
                      children: [
                        const Icon(Icons.article_outlined,
                            color: Colors.green, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          "Content",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.titleMedium?.color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.content,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    Divider(color: Theme.of(context).dividerColor),
                  ],
                  Row(
                    children: [
                      const Icon(Icons.person_outline,
                          color: Colors.purple, size: 20),
                      const SizedBox(width: 10),
                      Text(
                        widget.author.isNotEmpty
                            ? "By ${widget.author}"
                            : "Unknown Author",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
