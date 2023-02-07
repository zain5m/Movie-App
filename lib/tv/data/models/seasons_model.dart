import 'package:move/tv/domain/entities/seasons.dart';

class SeasonsModel extends Seasons {
  const SeasonsModel({
    required super.episodeCount,
    required super.id,
    required super.name,
    required super.seasonNumber,
  });

  factory SeasonsModel.fromJson(Map<String, dynamic> json) => SeasonsModel(
        episodeCount: json['episode_count'],
        id: json['id'],
        name: json['name'],
        seasonNumber: json['season_number'],
      );
}
