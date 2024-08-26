import 'package:hive/hive.dart';

part 'language_box_model.g.dart';

@HiveType(typeId: 0)
class LanguageBoxModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String imagePath;

  @HiveField(3)
  final int status;

  LanguageBoxModel(
      {required this.id,
      required this.name,
      required this.imagePath,
      required this.status});

  factory LanguageBoxModel.fromJson(Map<String, dynamic> json) {
    return LanguageBoxModel(
      id: json['id'] ?? 0,
      name: json['created_at'] ?? '',
      imagePath: json['image_path'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_path': imagePath,
      'status': status,
    };
  }
}
