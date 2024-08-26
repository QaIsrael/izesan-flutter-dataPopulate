import 'package:hive/hive.dart';

part 'lesson_box_model.g.dart';

@HiveType(typeId: 1)
class LessonBoxModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String createdAt;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String questionType;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String content;

  @HiveField(6)
  final String objective;

  @HiveField(7)
  final String mediaUrl;

  @HiveField(8)
  final String week;

  @HiveField(9)
  final String type;

  @HiveField(10)
  final List<dynamic> answered;

  @HiveField(11)
  final String mediaType;

  @HiveField(12)
  final String questions;

  @HiveField(13)
  final int questionCount;

  @HiveField(14)
  final int percentage;

  @HiveField(15)
  final String lastQuestionAnswered;

  LessonBoxModel({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.questionType,
    required this.description,
    required this.content,
    required this.objective,
    required this.mediaUrl,
    required this.week,
    required this.type,
    required this.answered,
    required this.mediaType,
    required this.questions,
    required this.questionCount,
    required this.percentage,
    required this.lastQuestionAnswered,
  });

  factory LessonBoxModel.fromJson(Map<String, dynamic> json) {
    return LessonBoxModel(
      id: json['id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      title: json['title'] ?? '',
      questionType: json['question_type'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      objective: json['objective'] ?? '',
      mediaUrl: json['media_url'] ?? '',
      week: json['week'] ?? '',
      type: json['type'] ?? '',
      answered: json['answered'] ?? [],
      mediaType: json['media_type'] ?? '',
      questions: json['questions'] ?? '',
      questionCount: json['question_count'] ?? 0,
      percentage: json['percentage'] ?? 0,
      lastQuestionAnswered: json['last_question_answered'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'title': title,
      'question_type': questionType,
      'description': description,
      'content': content,
      'objective': objective,
      'media_url': mediaUrl,
      'week': week,
      'type': type,
      'answered': answered,
      'media_type': mediaType,
      'questions': questions,
      'question_count': questionCount,
      'percentage': percentage,
      'last_question_answered': lastQuestionAnswered,
    };
  }
}
