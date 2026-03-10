import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../models/watchlist_model.dart';

class MovieListPage extends StatefulWidget {
  final String nama;
  const MovieListPage({super.key, required this.nama});
  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            elevation: 0,
            backgroundColor: const Color(0xFFF2F2F7),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors
                      .redAccent, 
                ),
                onPressed: () {
                  _showLogoutDialog(context);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.bookmarks_rounded,
                  color: Color.fromARGB(255, 255, 3, 226),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/watchlist').then((_) {
                    setState(() {});
                  });
                },
              ),
              const SizedBox(width: 12),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
              title: Text(
                'Halo, ${widget.nama}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
              background: Container(color: const Color(0xFFF2F2F7)),
            ),
          ),

          movieList.isEmpty
              ? const SliverFillRemaining(
                  child: Center(child: Text('Data film tidak ditemukan')),
                )
              : SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final movie = movieList[index];
                      bool isSaved = WatchlistModel.isSaved(movie);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/movieDetail',
                            arguments: movie,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                // Poster
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    movie.imgUrl,
                                    width: 80,
                                    height: 110,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '${movie.genre} • ${movie.year}',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Rating Badge
                                          _buildRatingBadge(movie.rating),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (isSaved) {
                                                  WatchlistModel.removeMovie(
                                                    movie,
                                                  );
                                                } else {
                                                  WatchlistModel.addMovie(
                                                    movie,
                                                  );
                                                }
                                              });
                                              _showFeedback(context, isSaved);
                                            },
                                            icon: Icon(
                                              isSaved
                                                  ? Icons.bookmark_rounded
                                                  : Icons
                                                        .bookmark_outline_rounded,
                                              color: isSaved
                                                  ? const Color.fromARGB(
                                                      255,
                                                      255,
                                                      3,
                                                      217,
                                                    )
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }, childCount: movieList.length),
                  ),
                ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Apakah anda yakin ingin keluar?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            child: const Text("Keluar", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBadge(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 3, 209).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.star_rounded,
            size: 16,
            color: Color.fromARGB(255, 255, 3, 200),
          ),
          const SizedBox(width: 4),
          Text(
            rating.toString(),
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 3, 221),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _showFeedback(BuildContext context, bool wasSaved) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(wasSaved ? 'Dihapus dari daftar' : 'Berhasil disimpan'),
        duration: const Duration(milliseconds: 600),
        behavior: SnackBarBehavior.floating,
        width: 200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
