import 'package:moviedetails/models/movie_cast_model.dart';
import 'package:moviedetails/models/movie_details_model.dart';
import 'package:moviedetails/models/movie_model.dart';
import 'package:moviedetails/service/movie_api_service.dart';

class MovieRepository {
  final MovieApiService api;

  MovieRepository({required this.api});

  /// Get trending movies
  Future<List<MovieModel>> getTrendingMovies({int page = 1}) async {
    final results = await api.getTrendingMovies(page: page);
    return results
        .map<MovieModel>((json) => MovieModel.fromJson(json))
        .toList();
  }

  /// Search movies
  Future<List<MovieModel>> searchMovies(String query) async {
    final results = await api.searchMovies(query);
    return results
        .map<MovieModel>((json) => MovieModel.fromJson(json))
        .toList();
  }

  /// Movie details
  Future<MovieDetailsModel> getMovieDetails(int id) async {
    final json = await api.getMovieDetails(id);
    return MovieDetailsModel.fromJson(json);
  }

  /// Movie cast
  Future<List<CastModel>> getMovieCast(int id) async {
    final results = await api.getMovieCast(id);
    return results.map<CastModel>((json) => CastModel.fromJson(json)).toList();
  }
}
