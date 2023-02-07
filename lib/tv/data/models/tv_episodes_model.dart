import 'package:move/tv/domain/entities/tv_episodes.dart';

class TvEpisodesModel extends TvEpisodes {
  const TvEpisodesModel({
    required super.airDate,
    required super.episodeNumber,
    required super.id,
    required super.name,
    required super.overview,
    required super.stillPath,
  });
  factory TvEpisodesModel.fromJson(
          Map<String, dynamic> json, Map<String, dynamic> json1) =>
      TvEpisodesModel(
        airDate: json["air_date"] ?? json1["air_date"],
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        stillPath: json["still_path"],
      );
}
