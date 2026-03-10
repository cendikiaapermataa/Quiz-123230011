import 'package:flutter/material.dart';
import 'screen/login_page.dart';
import 'screen/moviel_list_page.dart';
import 'screen/movie_detail_page.dart';
import 'screen/watchlist_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      initialRoute: '/',
      routes: {
        '/': (context) {
          return const LoginPage();
        },
        '/movieList': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          return MovieListPage(nama: args is String ? args : "User");
        },
        '/movieDetail': (context) {
          return const MovieDetailPage();
        },
        '/watchlist': (context) {
          return const WatchlistPage();
        },
      },
    );
  }
}
