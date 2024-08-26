import 'package:hive/hive.dart';

part 'video_lessons_box_model.g.dart';

@HiveType(typeId: 3)
class QuestionOptionHive extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String hint;

  @HiveField(3)
  final String? mediaUrl;

  @HiveField(4)
  final String? mediaType;

  @HiveField(5)
  final String? imageUrl;

  @HiveField(6)
  final int isCorrect;

  QuestionOptionHive({
    required this.id,
    required this.title,
    required this.hint,
    this.mediaUrl,
    this.mediaType,
    this.imageUrl,
    required this.isCorrect,
  });
}

@HiveType(typeId: 4)
class QuestionsHive extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String instruction;

  @HiveField(3)
  final int nextQuestionId;

  @HiveField(4)
  final String answeredType;

  @HiveField(5)
  final String? mediaUrl;

  @HiveField(6)
  final String? imageUrl;

  @HiveField(7)
  final String? mediaType;

  @HiveField(8)
  final List<QuestionOptionHive> options;

  @HiveField(9)
  final List<String> optionsScrambled;

  QuestionsHive({
    required this.id,
    required this.title,
    required this.instruction,
    required this.nextQuestionId,
    required this.answeredType,
    this.mediaUrl,
    this.imageUrl,
    this.mediaType,
    required this.options,
    required this.optionsScrambled,
  });
}

@HiveType(typeId: 5)
class TopicsHive extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final String createdAt;

  @HiveField(5)
  final String updatedAt;

  @HiveField(6)
  final String sectionId;

  @HiveField(7)
  final String mediaType;

  @HiveField(8)
  final String type;

  @HiveField(9)
  final String objective;

  @HiveField(10)
  final String content;

  @HiveField(11)
  final String questionType;

  @HiveField(12)
  final int schoolClassId;

  @HiveField(13)
  final int week;

  @HiveField(14)
  final List<dynamic> answered;

  @HiveField(15)
  final List<QuestionsHive> questions;

  @HiveField(16)
  final int questionCount;

  @HiveField(17)
  final int percentage;

  @HiveField(18)
  final dynamic lastQuestionAnswered;

  @HiveField(19)
  final String mediaUrl;

  TopicsHive({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.sectionId,
    required this.mediaType,
    required this.type,
    required this.objective,
    required this.content,
    required this.questionType,
    required this.schoolClassId,
    required this.week,
    required this.answered,
    required this.questions,
    required this.questionCount,
    required this.percentage,
    this.lastQuestionAnswered,
    required this.mediaUrl,
  });
}

@HiveType(typeId: 6)
class VideoLessonsBoxModelHive extends HiveObject {
  @HiveField(0)
  final String week;

  @HiveField(1)
  final List<TopicsHive> topics;

  VideoLessonsBoxModelHive({
    required this.week,
    required this.topics,
  });
}