class MovieModel {
  late final int id;
  late final String title;
  late final String? overview;
  late final String? posterPath;
  late final String? backdropPath;
  late final String? releaseDate;
  late final double rating;
  late final List<int> genreIds;

  MovieModel({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    required this.rating,
    required this.genreIds,
  });

  MovieModel copyWith({
    int? id,
    String? title,
    String? overview,
    String? posterPath,
    String? backdropPath,
    String? releaseDate,
    double? rating,
    List<int>? genreIds,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      releaseDate: releaseDate ?? this.releaseDate,
      rating: rating ?? this.rating,
      genreIds: genreIds ?? this.genreIds,
    );
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json["id"],
      title: json["title"] ?? "",
      overview: json["overview"],
      posterPath: json["poster_path"],
      backdropPath: json["backdrop_path"],
      releaseDate: json["release_date"],
      rating: (json["vote_average"] ?? 0).toDouble(),
      genreIds: List<int>.from(json["genre_ids"] ?? []),
    );
  }
}
