import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailsPage extends StatelessWidget {
  static const String routeName = '/movie-details';

  final dynamic movie; // Replace with your Movie model when ready

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // TOP POSTER BAR WITH HERO ANIMATION
          SliverAppBar(
            pinned: true,
            expandedHeight: 350,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie["title"],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              background: Hero(
                tag: movie["poster"],
                child: CachedNetworkImage(
                  imageUrl: movie["poster"],
                  fit: BoxFit.cover,
                ),
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
                  /// TITLE + YEAR
                  Text(
                    movie["title"],
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber.shade400, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        movie["rating"]?.toString() ?? "7.5",
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        movie["year"]?.toString() ?? "2024",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// GENRES
                  Wrap(
                    spacing: 8,
                    children:
                        (movie["genres"] ?? ["Action", "Thriller", "Adventure"])
                            .map<Widget>((g) {
                              return Chip(
                                label: Text(g),
                                backgroundColor: isDark
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade200,
                              );
                            })
                            .toList(),
                  ),

                  const SizedBox(height: 20),

                  /// DESCRIPTION
                  Text(
                    "Overview",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    movie["description"] ??
                        "This is a sample description for this movie. Replace "
                            "this with actual overview from your API.",
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),

                  const SizedBox(height: 24),

                  /// CAST SECTION
                  Text(
                    "Cast",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(height: 130, child: _buildCastList(isDark)),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// HORIZONTAL CAST LIST
  Widget _buildCastList(bool isDark) {
    // Replace with your API cast list later
    final dummyCast = List.generate(
      10,
      (i) => {
        "name": "Actor $i",
        "image":
            "https://image.tmdb.org/t/p/w500/3fP7C7Qe5z9Y2HzFG1aFMEGgxoY.jpg",
      },
    );

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: dummyCast.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (context, i) {
        final actor = dummyCast[i];

        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                imageUrl: actor["image"].toString(),
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                placeholder: (_, __) => _shimmerCircle(isDark),
                errorWidget: (_, __, ___) => _shimmerCircle(isDark),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 70,
              child: Text(
                actor["name"].toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        );
      },
    );
  }

  /// SHIMMER FOR CAST IMAGES
  Widget _shimmerCircle(bool isDark) {
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[900]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[800]! : Colors.grey[100]!,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      ),
    );
  }
}
