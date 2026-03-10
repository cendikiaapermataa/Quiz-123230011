import 'movie_model.dart';

class WatchlistModel {
  static final List<MovieModel> _savedMovies = [];
  static List<MovieModel> get allMovies => _savedMovies;

  static void addMovie(MovieModel movie) {
    if (!_savedMovies.contains(movie)) {
      _savedMovies.add(movie);
    }
  }

  static void removeMovie(MovieModel movie) {
    _savedMovies.remove(movie);
  }

  static bool isSaved(MovieModel movie) {
    return _savedMovies.contains(movie);
  }
}
