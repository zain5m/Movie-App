import 'package:move/tv/domain/entities/tv_recommendation.dart';

class TvRecommendationModel extends TvRecommendation {
  const TvRecommendationModel({
    required super.backdropPath,
    required super.id,
    required super.name,
  });
  factory TvRecommendationModel.fromJson(Map<String, dynamic> json) =>
      TvRecommendationModel(
        backdropPath: json['backdrop_path'],
        id: json['id'],
        name: json['name'],
      );
  @override
  List<Object?> get props => [
        backdropPath,
        id,
        name,
      ];
}
