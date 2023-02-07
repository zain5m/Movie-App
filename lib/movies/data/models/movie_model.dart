import 'package:move/movies/domain/entities/movie.dart';

class MovieModue extends Movie {
  const MovieModue({
    required super.id,
    required super.title,
    required super.backdropPath,
    required super.overview,
    required super.genreIds,
    required super.voteAverage,
    required super.releaseDate,
  });

  factory MovieModue.fromJson(Map<String, dynamic> json) => MovieModue(
        id: json['id'],
        title: json['title'],
        // Todo:
        backdropPath: json['backdrop_path'],
        overview: json['overview'],
        genreIds: List<int>.from(json['genre_ids'].map((e) => e)),
        voteAverage: json['vote_average'].toDouble(),
        releaseDate: json['release_date'],
      );
}
