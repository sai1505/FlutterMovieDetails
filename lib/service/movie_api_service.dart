import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moviedetails/core/api_constants.dart';

class MovieApiService {
  late final Dio _dio;

  MovieApiService() {
    final token = dotenv.env['TMDB_READ_ACCESS_TOKEN'];

    _dio = Dio()
      ..options.headers = {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      };
  }

  Future<List<dynamic>> getTrendingMovies() async {
    final response = await _dio.get(
      "${ApiConstants.baseUrl}/trending/movie/day",
      queryParameters: {
        "language": "en-US",
        // ❌ remove api_key
      },
    );
    return response.data["results"];
  }

  Future<List<dynamic>> searchMovies(String query) async {
    final response = await _dio.get(
      "${ApiConstants.baseUrl}/search/movie",
      queryParameters: {
        "language": "en-US",
        "query": query,
        "include_adult": false,
        // ❌ remove api_key
      },
    );
    return response.data["results"];
  }

  Future<Map<String, dynamic>> getMovieDetails(int id) async {
    final response = await _dio.get(
      "${ApiConstants.baseUrl}/movie/$id",
      queryParameters: {
        "language": "en-US",
        // ❌ remove api_key
      },
    );
    return response.data;
  }

  Future<List<dynamic>> getMovieCast(int id) async {
    final response = await _dio.get(
      "${ApiConstants.baseUrl}/movie/$id/credits",
      queryParameters: {
        "language": "en-US",
        // ❌ remove api_key
      },
    );
    return response.data["cast"];
  }
}
