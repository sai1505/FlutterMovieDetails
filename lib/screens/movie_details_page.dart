import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:moviedetails/blocs/bloc/movies_bloc.dart';

class MovieDetailsPage extends StatefulWidget {
  static const String routeName = '/movie-details';
  final int movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  void initState() {
    super.initState();

    // Fetch movie details + cast from BLoC
    context.read<MoviesBloc>().add(FetchMovieDetails(widget.movieId));
    context.read<MoviesBloc>().add(FetchMovieCast(widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state.isLoading || state.details == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final movie = state.details!;
        final cast = state.cast;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // TOP POSTER BAR
              SliverAppBar(
                pinned: true,
                expandedHeight: 350,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  background: CachedNetworkImage(
                    imageUrl:
                        "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // CONTENT
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TITLE
                      Text(
                        movie.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber.shade400,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.releaseDate!.substring(0, 4),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // GENRES
                      Wrap(
                        spacing: 8,
                        children: movie.genres
                            .map(
                              (g) => Chip(
                                label: Text(g.name),
                                backgroundColor: isDark
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade200,
                              ),
                            )
                            .toList(),
                      ),

                      const SizedBox(height: 20),

                      // OVERVIEW
                      Text(
                        "Overview",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.overview.toString(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // CAST
                      Text(
                        "Cast",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      SizedBox(
                        height: 130,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: cast.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, i) {
                            final actor = cast[i];
                            return Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/w500${actor.profilePath}",
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    actor.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
