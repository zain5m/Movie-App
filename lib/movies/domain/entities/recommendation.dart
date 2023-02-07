import 'package:equatable/equatable.dart';

class Recommendation extends Equatable {
  final String? backdropPath;
  final int id;
  final String title;

  const Recommendation({
    this.backdropPath,
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        id,
        title,
      ];
}
