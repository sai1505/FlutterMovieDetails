part of 'movies_bloc.dart';

@immutable
class MoviesState extends Equatable {
  final bool isLoading;
  final List<MovieModel> movies;
  final MovieDetailsModel? details;
  final List<CastModel> cast;
  final String? error;

  const MoviesState({
    this.isLoading = false,
    this.movies = const [],
    this.details,
    this.cast = const [],
    this.error,
  });

  MoviesState copywith({
    bool? isLoading,
    List<MovieModel>? movies,
    MovieDetailsModel? details,
    List<CastModel>? cast,
    String? error,
  }) {
    return MoviesState(
      isLoading: isLoading ?? this.isLoading,
      movies: movies ?? this.movies,
      details: details ?? this.details,
      cast: cast ?? this.cast,
      error: error,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, movies, details, cast, error];
}
