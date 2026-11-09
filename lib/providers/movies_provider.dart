import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '14a57257c8b377a70d93bda9268b16bb';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';
  final String _page = '1';

  List<Movie> OnDisplayMovie = [];
  List<Movie> PopularMovie = [];

  // Cache: si ja hem demanat el càsting d'una peli, no el tornam a demanar
  Map<int, List<Cast>> movieCast = {};

  MoviesProvider() {
    // print('Movies Provider inicialitzat!');
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    // print('getOnDisplayMovies');
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page,
    }
    );

    final result = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromRawJson(result.body);
    OnDisplayMovie = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    // print('getPopularMovies');
    var url = Uri.https(_baseUrl, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page,
    }
    );

    final result = await http.get(url);

    final popularResponse = PopularResponse.fromRawJson(result.body);
    PopularMovie = popularResponse.results;

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;

    // print('getMovieCast $movieId');
    var url = Uri.https(_baseUrl, '3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final result = await http.get(url);

    final creditsResponse = CreditsResponse.fromRawJson(result.body);
    movieCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
