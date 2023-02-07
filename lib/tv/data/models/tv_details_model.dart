import 'package:move/movies/data/models/genres_model.dart';
import 'package:move/tv/data/models/seasons_model.dart';
import 'package:move/tv/domain/entities/tv_details.dart';

class TvDetailsModel extends TvDetails {
  const TvDetailsModel({
    required super.backdropPath,
    required super.episodeRunTime,
    required super.genres,
    required super.id,
    required super.name,
    required super.overview,
    required super.voteAverage,
    required super.firstAirDate,
    required super.numberOfSeasons,
    required super.seasons,
  });
  factory TvDetailsModel.fromJson(Map<String, dynamic> json) {
    return TvDetailsModel(
      episodeRunTime: List.from(json["episode_run_time"].map((m) => m)),
      backdropPath: json["backdrop_path"],
      genres: List.from(json["genres"].map((m) => GenresModel.fromJson(m))),
      id: json["id"],
      name: json["name"],
      overview: json["overview"],
      voteAverage: json["vote_average"].toDouble(),
      firstAirDate: json["first_air_date"],
      numberOfSeasons: json["number_of_seasons"],
      seasons: List.from(json["seasons"].map((m) => SeasonsModel.fromJson(m))),
    );
  }
}
