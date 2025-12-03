import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:moviedetails/blocs/bloc/movies_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailsPage extends StatefulWidget {
  static const String routeName = '/movie-details';
  final int movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      final bloc = context.read<MoviesBloc>();
      bloc.add(FetchMovieDetails(widget.movieId));
      bloc.add(FetchMovieCast(widget.movieId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        // ❗ SHIMMER LOADING
        // LIGHTWEIGHT SHIMMER LOADING
        if (state.isLoading || state.details == null) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade800,
                highlightColor: Colors.grey.shade700,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Poster placeholder
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Title
                    Container(
                      height: 22,
                      width: 200,
                      color: Colors.grey.shade900,
                    ),

                    const SizedBox(height: 12),

                    // Metadata row
                    Row(
                      children: [
                        Container(
                          height: 16,
                          width: 60,
                          color: Colors.grey.shade900,
                        ),
                        const SizedBox(width: 12),
                        Container(
                          height: 16,
                          width: 60,
                          color: Colors.grey.shade900,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Overview lines
                    ...List.generate(
                      3,
                      (i) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          height: 14,
                          width: double.infinity,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Cast title
                    Container(
                      height: 18,
                      width: 100,
                      color: Colors.grey.shade900,
                    ),

                    const SizedBox(height: 12),

                    // Cast circles (lightweight)
                    SizedBox(
                      height: 80,
                      child: Row(
                        children: List.generate(
                          5,
                          (i) => Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade900,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  height: 10,
                                  width: 50,
                                  color: Colors.grey.shade900,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // ❗ REAL DATA UI
        final movie = state.details!;
        final cast = state.cast;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
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
                    placeholder: (_, __) => Container(color: Colors.black12),
                    fadeInDuration: const Duration(milliseconds: 100),
                    memCacheHeight: 500,
                    filterQuality: FilterQuality.low,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: theme.textTheme.headlineMedium?.copyWith(
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
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

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

                      Text(
                        "Overview",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.overview.toString(),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      Text(
                        "Cast",
                        style: theme.textTheme.titleLarge?.copyWith(
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
                                    placeholder: (_, __) =>
                                        CircleAvatar(radius: 35),
                                    memCacheHeight: 200,
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
