import 'package:move/movies/domain/entities/movie.dart';
import 'package:move/tv/domain/entities/tv.dart';

class TvModel extends Tv {
  const TvModel({
    required super.id,
    required super.name,
    required super.backdropPath,
    required super.overview,
    required super.genreIds,
    required super.voteAverage,
    // required super.releaseDate,
  });

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        id: json['id'],
        name: json['name'],
        backdropPath: json['backdrop_path'],
        overview: json['overview'],
        genreIds: List<int>.from(json['genre_ids'].map((e) => e)),
        voteAverage: json['vote_average'].toDouble(),
        // releaseDate: json['release_date'],
      );
}
