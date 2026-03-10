// lib/screen/watchlist_page.dart
import 'package:flutter/material.dart';
import '../models/watchlist_model.dart'; 

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    final savedMovies = WatchlistModel.allMovies;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150.0,
            pinned: true,
            elevation: 0,
            backgroundColor: const Color(0xFFF2F2F7),
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                'Daftar Simpan',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          savedMovies.isEmpty
              ? const SliverFillRemaining(
                  child: Center(child: Text('Belum ada film yang disimpan')),
                )
              : SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final movie = savedMovies[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              movie.imgUrl,
                              width: 60,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            movie.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(movie.genre),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              setState(() {
                                WatchlistModel.removeMovie(movie);
                              });
                            },
                          ),
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/movieDetail',
                            arguments: movie,
                          ),
                        ),
                      );
                    }, childCount: savedMovies.length),
                  ),
                ),
        ],
      ),
    );
  }
}
