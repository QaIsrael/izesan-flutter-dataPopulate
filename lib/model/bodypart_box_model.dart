import 'package:hive/hive.dart';

part 'bodypart_box_model.g.dart';

@HiveType(typeId: 7)
class BodyPartBoxModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String instruction;

  @HiveField(3)
  String nextQuestionId;

  @HiveField(4)
  String answeredType;

  @HiveField(5)
  String mediaUrl;

  @HiveField(6)
  String imageUrl;

  @HiveField(7)
  String mediaType;

  // @HiveField(8)
  // TopicBodyPart topic;

  @HiveField(9)
  List<OptionBodyPart> options;

  @HiveField(10)
  LanguageBodyPart language;

  BodyPartBoxModel({
    required this.id,
    required this.title,
    required this.instruction,
    required this.nextQuestionId,
    required this.answeredType,
    required this.mediaUrl,
    required this.imageUrl,
    required this.mediaType,
    // required this.topic,
    required this.options,
    required this.language,
  });
}

// @HiveType(typeId: 8)
// class TopicBodyPart {
//   @HiveField(0)
//   int id;
//
//   @HiveField(1)
//   String title;
//
//   @HiveField(2)
//   String description;
//
//   TopicBodyPart({
//     required this.id,
//     required this.title,
//     required this.description,
//   });
// }

@HiveType(typeId: 9)
class OptionBodyPart {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String hint;

  @HiveField(3)
  String mediaUrl;

  @HiveField(4)
  String mediaType;

  @HiveField(5)
  int isCorrect;

  @HiveField(6)
  String imageUrl;

  @HiveField(7)
  String localImageUrl;

  @HiveField(8)
  String localMediaUrl;


  OptionBodyPart({
    required this.id,
    required this.title,
    required this.hint,
    required this.mediaUrl,
    required this.mediaType,
    required this.isCorrect,
    required this.imageUrl,
    required this.localImageUrl,
    required this.localMediaUrl
  });
}

@HiveType(typeId: 10)
class LanguageBodyPart {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  LanguageBodyPart({
    required this.id,
    required this.name,
  });
}