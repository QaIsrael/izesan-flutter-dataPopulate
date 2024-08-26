class Lessons {
  final int id;
  final String createdAt;
  final String title;
  final String questionType;
  final String description;
  final String content;
  final String objective;
  final String mediaUrl;
  final String week;
  final String type;
  final List<dynamic> answered;
  final String mediaType;
  final String questions;
  final int questionCount;
  final int percentage;
  final String lastQuestionAnswered;

  Lessons({
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

  factory Lessons.fromJson(Map<String, dynamic> json) {
    return Lessons(
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
