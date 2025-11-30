part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTrendingMovies extends MoviesEvent {}

class SearchMovies extends MoviesEvent {
  final String query;
  SearchMovies(this.query);

  @override
  List<Object?> get props => [query];
}

class FetchMovieDetails extends MoviesEvent {
  final int movieid;
  FetchMovieDetails(this.movieid);

  @override
  List<Object?> get props => [movieid];
}

class FetchMovieCast extends MoviesEvent {
  final int movieId;
  FetchMovieCast(this.movieId);

  @override
  List<Object?> get props => [movieId];
}
