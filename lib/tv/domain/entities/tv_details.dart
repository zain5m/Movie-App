import 'package:equatable/equatable.dart';
import 'package:move/movies/domain/entities/genres.dart';
import 'package:move/tv/domain/entities/seasons.dart';

class TvDetails extends Equatable {
  final String? backdropPath;
  final List<Genres> genres;
  final int id;
  final String name;
  final String overview;
  final double voteAverage;
  final String firstAirDate;
  final int numberOfSeasons;
  final List<Seasons> seasons;
  final List<int> episodeRunTime;
  const TvDetails({
    required this.episodeRunTime,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.firstAirDate,
    required this.numberOfSeasons,
    required this.seasons,
  });
  @override
  List<Object?> get props => [
        episodeRunTime,
        backdropPath,
        genres,
        id,
        name,
        overview,
        voteAverage,
        firstAirDate,
        numberOfSeasons,
        seasons,
      ];
}
