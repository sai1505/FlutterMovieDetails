import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviedetails/screens/movie_details_page.dart';
import 'package:shimmer/shimmer.dart';

class MoviesListPage extends StatefulWidget {
  static const String routeName = '/movies-list';

  const MoviesListPage({super.key});

  @override
  State<MoviesListPage> createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  Timer? _debounce;

  bool _isLoading = true;
  List<dynamic> _movies = [];
  List<dynamic> _filteredMovies = [];

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _fetchMovies() async {
    // TODO: Replace with your API call
    await Future.delayed(const Duration(seconds: 1));

    // TEMP dummy movies (replace with API result)
    final tempMovies = List.generate(
      20,
      (i) => {
        "title": "Movie $i",
        "poster":
            "https://image.tmdb.org/t/p/w500/8YFL5QQVPy3AgrEQxNYVSgiPEbe.jpg",
      },
    );

    setState(() {
      _movies = tempMovies;
      _filteredMovies = tempMovies;
      _isLoading = false;
    });
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      query = query.toLowerCase().trim();

      setState(() {
        _filteredMovies = _movies.where((movie) {
          final title = movie["title"].toLowerCase();
          return title.contains(query);
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text("Movies"), centerTitle: true),
      body: Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
            child: TextField(
              controller: _searchCtrl,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: "Search movies...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          Expanded(
            child: _isLoading ? _buildShimmerGrid(isDark) : _buildMoviesGrid(),
          ),
        ],
      ),
    );
  }

  // GRID WHEN DATA IS READY
  Widget _buildMoviesGrid() {
    if (_filteredMovies.isEmpty) {
      return const Center(child: Text("No movies found"));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _filteredMovies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.55,
      ),
      itemBuilder: (context, i) {
        final movie = _filteredMovies[i];

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              MovieDetailsPage.routeName,
              arguments: movie,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // POSTER
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: movie["poster"],
                    fit: BoxFit.cover,
                    placeholder: (_, __) =>
                        Container(color: Colors.grey.shade800),
                    errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
                  ),
                ),
              ),

              const SizedBox(height: 6),

              // TITLE
              Text(
                movie["title"],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      },
    );
  }

  // SHIMMER LOADING GRID
  Widget _buildShimmerGrid(bool isDark) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 12,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.55,
      ),
      itemBuilder: (context, i) {
        return Shimmer.fromColors(
          baseColor: isDark ? Colors.grey[900]! : Colors.grey[300]!,
          highlightColor: isDark ? Colors.grey[800]! : Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}
