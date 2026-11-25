import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

/// Proyek portofolio yang tersinkron dengan API Django REST Framework
/// (`ProjectSerializer` di backend myportofolio).
@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    required this.title,
    required this.description,
    required this.category,
    this.projectImageUrl = '',
    this.id,
    this.starCount = 0,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  /// UUID yang dibuat oleh Django, jadi tidak ikut dikirim saat POST.
  @JsonKey(includeToJson: false)
  final String? id;

  final String title;
  final String description;
  final String category;

  /// Opsional di backend (boleh kosong atau null).
  @JsonKey(defaultValue: '')
  final String projectImageUrl;

  /// Field hitungan dari server (read-only).
  @JsonKey(includeToJson: false, defaultValue: 0)
  final int starCount;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
