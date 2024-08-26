class Language {
  final int id;
  final String name;
  final String imageUrl;
  final String createdAt;
  final String updatedAt;
  final int status;
  final int order;

  Language({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.order,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      imageUrl: json['image_url'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      status: json['status'] ?? 0,
      order: json['order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'status': status,
      'order': order,
    };
  }
}

class Option {
  final String id;
  final String title;
  final String hint;
  final String? mediaUrl;
  final String? mediaType;
  final String? imageUrl;
  final int isCorrect;

  Option({
    required this.id,
    required this.title,
    required this.hint,
    this.mediaUrl,
    this.mediaType,
    this.imageUrl,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      hint: json['hint'] ?? '',
      mediaUrl: json['media_url'],
      mediaType: json['media_type'],
      imageUrl: json['image_url'],
      isCorrect: json['is_correct'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'hint': hint,
      'media_url': mediaUrl,
      'media_type': mediaType,
      'image_url': imageUrl,
      'is_correct': isCorrect,
    };
  }
}

class Question {
  final String id;
  final String title;
  final String instruction;
  final int nextQuestionId;
  final String answeredType;
  final String? mediaUrl;
  final String? imageUrl;
  final String? mediaType;
  final Language language;
  final List<Option> options;
  final List<String> optionsScrambled;

  Question({
    required this.id,
    required this.title,
    required this.instruction,
    required this.nextQuestionId,
    required this.answeredType,
    this.mediaUrl,
    this.imageUrl,
    this.mediaType,
    required this.language,
    required this.options,
    required this.optionsScrambled,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      instruction: json['instruction'] ?? '',
      nextQuestionId: json['next_question_id'] ?? 0,
      answeredType: json['answered_type'] ?? '',
      mediaUrl: json['media_url'],
      imageUrl: json['image_url'],
      mediaType: json['media_type'],
      language: Language.fromJson(json['language'] ?? {}),
      options: (json['options'] as List<dynamic>?)
          ?.map((option) => Option.fromJson(option))
          .toList() ??
          [],
      optionsScrambled: (json['optionsScrambled'] as List<dynamic>?)
          ?.map((option) => option.toString())
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'instruction': instruction,
      'next_question_id': nextQuestionId,
      'answered_type': answeredType,
      'media_url': mediaUrl,
      'image_url': imageUrl,
      'media_type': mediaType,
      'language': language.toJson(),
      'options': options.map((option) => option.toJson()).toList(),
      'optionsScrambled': optionsScrambled,
    };
  }
}

class Topics {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String createdAt;
  final String updatedAt;
  final String sectionId;
  final String mediaType;
  final String mediaUrl;
  final String type;
  final String objective;
  final String content;
  final String questionType;
  final int schoolClassId;
  final int week;
  final List<dynamic> answered;
  final List<Question> questions;
  final int questionCount;
  final int percentage;
  final dynamic lastQuestionAnswered;

  Topics({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.sectionId,
    required this.mediaUrl,
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
  });

  factory Topics.fromJson(Map<String, dynamic> json) {
    return Topics(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      sectionId: json['section_id'] ?? '',
      mediaType: json['media_type'] ?? '',
      mediaUrl: json['media_url'] ?? '',
      type: json['type'] ?? '',
      objective: json['objective'] ?? '',
      content: json['content'] ?? '',
      questionType: json['question_type'] ?? '',
      schoolClassId: json['schoolClassId'] ?? 0,
      week: json['week'] ?? 0,
      answered: json['answered'] ?? [],
      questions: (json['questions'] as List<dynamic>?)
          ?.map((question) => Question.fromJson(question))
          .toList() ??
          [],
      questionCount: json['question_count'] ?? 0,
      percentage: json['percentage'] ?? 0,
      lastQuestionAnswered: json['last_question_answered'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'section_id': sectionId,
      'media_type': mediaType,
      'type': type,
      'objective': objective,
      'content': content,
      'question_type': questionType,
      'schoolClassId': schoolClassId,
      'week': week,
      'answered': answered,
      'questions': questions.map((question) => question.toJson()).toList(),
      'question_count': questionCount,
      'percentage': percentage,
      'last_question_answered': lastQuestionAnswered,
    };
  }
}

class VideoLessons {
  final String week;
  final List<Topics> topics;

  VideoLessons({
    required this.week,
    required this.topics,
  });

  factory VideoLessons.fromJson(Map<String, dynamic> json) {
    return VideoLessons(
      week: json['week'] ?? '',
      topics: (json['topics'] as List<dynamic>?)
          ?.map((topic) => Topics.fromJson(topic)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'week': week,
      'topics': topics.map((topic) => topic.toJson()).toList(),
    };
  }

  static List<VideoLessons> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => VideoLessons.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<VideoLessons> weekList) {
    return weekList.map((week) => week.toJson()).toList();
  }
}