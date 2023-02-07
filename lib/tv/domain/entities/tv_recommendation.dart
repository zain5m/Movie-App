import 'package:equatable/equatable.dart';

class TvRecommendation extends Equatable {
  final String? backdropPath;
  final int id;
  final String name;

  const TvRecommendation({
    required this.backdropPath,
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        id,
        name,
      ];
}
