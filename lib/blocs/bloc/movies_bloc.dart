import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:moviedetails/models/movie_cast_model.dart';
import 'package:moviedetails/models/movie_details_model.dart';
import 'package:moviedetails/models/movie_model.dart';
import 'package:moviedetails/repos/movie_repository.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepository movieRepository;

  MoviesBloc(this.movieRepository) : super(const MoviesState()) {
    on<FetchTrendingMovies>(_onFetchTrendingMovies);
    on<SearchMovies>(_onSearchMovies);
    on<FetchMovieDetails>(_onFetchMovieDetails);
    on<FetchMovieCast>(_onFetchMovieCast);
    on<FetchNextPage>(_onFetchNextPage);
  }

  Future<void> _onFetchTrendingMovies(
    FetchTrendingMovies event,
    Emitter<MoviesState> emit,
  ) async {
    emit(state.copywith(isLoading: true, currentPage: 1));

    try {
      final movies = await movieRepository.getTrendingMovies(page: 1);
      emit(
        state.copywith(
          isLoading: false,
          movies: movies,
          currentPage: 1,
          isFetchingMore: false,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copywith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onSearchMovies(
    SearchMovies event,
    Emitter<MoviesState> emit,
  ) async {
    emit(state.copywith(isLoading: true));

    try {
      final movies = await movieRepository.searchMovies(event.query);
      emit(state.copywith(isLoading: false, movies: movies));
    } catch (e) {
      emit(state.copywith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onFetchMovieDetails(
    FetchMovieDetails event,
    Emitter<MoviesState> emit,
  ) async {
    emit(state.copywith(isLoading: true));

    try {
      final details = await movieRepository.getMovieDetails(event.movieid);
      emit(state.copywith(isLoading: false, details: details));
    } catch (e) {
      emit(state.copywith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onFetchMovieCast(
    FetchMovieCast event,
    Emitter<MoviesState> emit,
  ) async {
    emit(state.copywith(isLoading: true));

    try {
      final cast = await movieRepository.getMovieCast(event.movieId);
      emit(state.copywith(isLoading: false, cast: cast));
    } catch (e) {
      emit(state.copywith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onFetchNextPage(
    FetchNextPage event,
    Emitter<MoviesState> emit,
  ) async {
    // already loading more → ignore
    if (state.isFetchingMore) return;

    emit(state.copywith(isFetchingMore: true));

    final nextPage = state.currentPage + 1;

    try {
      final newMovies = await movieRepository.getTrendingMovies(page: nextPage);

      // if API returns empty → no more pages
      if (newMovies.isEmpty) {
        emit(state.copywith(isFetchingMore: false));
        return;
      }

      emit(
        state.copywith(
          isFetchingMore: false,
          currentPage: nextPage,
          movies: [...state.movies, ...newMovies],
        ),
      );
    } catch (e) {
      emit(
        state.copywith(
          isFetchingMore: false,
          error: e.toString(),
        ),
      );
    }
  }
}
