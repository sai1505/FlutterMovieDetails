part of 'movies_bloc.dart';

@immutable
class MoviesState extends Equatable {
  final bool isLoading;
  final List<MovieModel> movies;
  final MovieDetailsModel? details;
  final List<CastModel> cast;
  final String? error;

  final int currentPage; // add this
  final bool isFetchingMore; // add this

  const MoviesState({
    this.isLoading = false,
    this.movies = const [],
    this.details,
    this.cast = const [],
    this.error,
    this.currentPage = 1,
    this.isFetchingMore = false,
  });

  MoviesState copywith({
    bool? isLoading,
    List<MovieModel>? movies,
    MovieDetailsModel? details,
    List<CastModel>? cast,
    String? error,
    int? currentPage,
    bool? isFetchingMore,
  }) {
    return MoviesState(
      isLoading: isLoading ?? this.isLoading,
      movies: movies ?? this.movies,
      details: details ?? this.details,
      cast: cast ?? this.cast,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    movies,
    details,
    cast,
    error,
    currentPage,
    isFetchingMore,
  ];
}
