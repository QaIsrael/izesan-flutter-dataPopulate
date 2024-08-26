// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_lessons_box_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionOptionHiveAdapter extends TypeAdapter<QuestionOptionHive> {
  @override
  final int typeId = 3;

  @override
  QuestionOptionHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionOptionHive(
      id: fields[0] as String,
      title: fields[1] as String,
      hint: fields[2] as String,
      mediaUrl: fields[3] as String?,
      mediaType: fields[4] as String?,
      imageUrl: fields[5] as String?,
      isCorrect: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionOptionHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.hint)
      ..writeByte(3)
      ..write(obj.mediaUrl)
      ..writeByte(4)
      ..write(obj.mediaType)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.isCorrect);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionOptionHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuestionsHiveAdapter extends TypeAdapter<QuestionsHive> {
  @override
  final int typeId = 4;

  @override
  QuestionsHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionsHive(
      id: fields[0] as String,
      title: fields[1] as String,
      instruction: fields[2] as String,
      nextQuestionId: fields[3] as int,
      answeredType: fields[4] as String,
      mediaUrl: fields[5] as String?,
      imageUrl: fields[6] as String?,
      mediaType: fields[7] as String?,
      options: (fields[8] as List).cast<QuestionOptionHive>(),
      optionsScrambled: (fields[9] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuestionsHive obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.instruction)
      ..writeByte(3)
      ..write(obj.nextQuestionId)
      ..writeByte(4)
      ..write(obj.answeredType)
      ..writeByte(5)
      ..write(obj.mediaUrl)
      ..writeByte(6)
      ..write(obj.imageUrl)
      ..writeByte(7)
      ..write(obj.mediaType)
      ..writeByte(8)
      ..write(obj.options)
      ..writeByte(9)
      ..write(obj.optionsScrambled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionsHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TopicsHiveAdapter extends TypeAdapter<TopicsHive> {
  @override
  final int typeId = 5;

  @override
  TopicsHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TopicsHive(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      imageUrl: fields[3] as String,
      createdAt: fields[4] as String,
      updatedAt: fields[5] as String,
      sectionId: fields[6] as String,
      mediaType: fields[7] as String,
      type: fields[8] as String,
      objective: fields[9] as String,
      content: fields[10] as String,
      questionType: fields[11] as String,
      schoolClassId: fields[12] as int,
      week: fields[13] as int,
      answered: (fields[14] as List).cast<dynamic>(),
      questions: (fields[15] as List).cast<QuestionsHive>(),
      questionCount: fields[16] as int,
      percentage: fields[17] as int,
      lastQuestionAnswered: fields[18] as dynamic,
      mediaUrl: fields[19] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TopicsHive obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.sectionId)
      ..writeByte(7)
      ..write(obj.mediaType)
      ..writeByte(8)
      ..write(obj.type)
      ..writeByte(9)
      ..write(obj.objective)
      ..writeByte(10)
      ..write(obj.content)
      ..writeByte(11)
      ..write(obj.questionType)
      ..writeByte(12)
      ..write(obj.schoolClassId)
      ..writeByte(13)
      ..write(obj.week)
      ..writeByte(14)
      ..write(obj.answered)
      ..writeByte(15)
      ..write(obj.questions)
      ..writeByte(16)
      ..write(obj.questionCount)
      ..writeByte(17)
      ..write(obj.percentage)
      ..writeByte(18)
      ..write(obj.lastQuestionAnswered)
      ..writeByte(19)
      ..write(obj.mediaUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopicsHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VideoLessonsBoxModelHiveAdapter
    extends TypeAdapter<VideoLessonsBoxModelHive> {
  @override
  final int typeId = 6;

  @override
  VideoLessonsBoxModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoLessonsBoxModelHive(
      week: fields[0] as String,
      topics: (fields[1] as List).cast<TopicsHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, VideoLessonsBoxModelHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.week)
      ..writeByte(1)
      ..write(obj.topics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoLessonsBoxModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
