class MovieDetailsModel {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double rating;
  final int runtime;
  final List<GenreModel> genres;

  MovieDetailsModel({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    required this.rating,
    required this.runtime,
    required this.genres,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json["id"],
      title: json["title"] ?? "",
      overview: json["overview"],
      posterPath: json["poster_path"],
      backdropPath: json["backdrop_path"],
      releaseDate: json["release_date"],
      rating: (json["vote_average"] ?? 0).toDouble(),
      runtime: json["runtime"] ?? 0,
      genres:
          (json["genres"] as List<dynamic>?)
              ?.map((g) => GenreModel.fromJson(g))
              .toList() ??
          [],
    );
  }
}

class GenreModel {
  final int id;
  final String name;

  GenreModel({
    required this.id,
    required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json["id"],
      name: json["name"] ?? "",
    );
  }
}
