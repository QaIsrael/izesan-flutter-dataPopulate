class BodyPartModel {
  String id;
  String title;
  String instruction;
  String nextQuestionId;
  String answeredType;
  String mediaUrl;
  String imageUrl;
  String mediaType;
  // TopicBP topic;
  List<OptionBP> options;
  LanguageBP language;

  BodyPartModel({
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

  factory BodyPartModel.fromJson(Map<String, dynamic> json) {
    return BodyPartModel(
      id: json['id'],
      title: json['title'],
      instruction: json['instruction'],
      nextQuestionId: json['next_question_id'].toString(),
      answeredType: json['answered_type'],
      mediaUrl: json['media_url'] ?? '',
      imageUrl: json['image_url'] ?? '',
      mediaType: json['media_type'],
      // topic: TopicBP.fromJson(json['topic']),
      options: (json['options'] as List).map((e) => OptionBP.fromJson(e)).toList(),
      language: LanguageBP.fromJson(json['language']),
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
      // 'topic': topic.toJson(),
      'options': options.map((e) => e.toJson()).toList(),
      'language': language.toJson(),
    };
  }
}

// class TopicBP {
//   int id;
//   String title;
//   String description;
//
//   TopicBP({
//     required this.id,
//     required this.title,
//     required this.description,
//   });
//
//   factory TopicBP.fromJson(Map<String, dynamic> json) {
//     return TopicBP(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//     };
//   }
// }

class OptionBP {
  String id;
  String title;
  String hint;
  String mediaUrl;
  String mediaType;
  int isCorrect;
  String imageUrl;
  String? localMediaUrl;
  String? localImageUrl;

  OptionBP({
    required this.id,
    required this.title,
    required this.hint,
    required this.mediaUrl,
    required this.mediaType,
    required this.isCorrect,
    required this.imageUrl,
    this.localMediaUrl,
    this.localImageUrl,
  });

  factory OptionBP.fromJson(Map<String, dynamic> json) {
    return OptionBP(
      id: json['id'],
      title: json['title'],
      hint: json['hint'] ?? '',
      mediaUrl: json['media_url'] ?? '',
      mediaType: json['media_type'],
      isCorrect: json['is_correct'],
      imageUrl: json['image_url'] ?? '',
      localMediaUrl: json['localMediaUrl'] ?? '',
      localImageUrl: json['localImageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'hint': hint,
      'media_url': mediaUrl,
      'media_type': mediaType,
      'is_correct': isCorrect,
      'image_url': imageUrl,
      'localMediaUrl': localMediaUrl,
      'localImageUrl': localImageUrl,
    };
  }
}

class LanguageBP {
  int id;
  String name;

  LanguageBP({
    required this.id,
    required this.name,
  });

  factory LanguageBP.fromJson(Map<String, dynamic> json) {
    return LanguageBP(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
