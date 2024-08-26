// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_box_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonBoxModelAdapter extends TypeAdapter<LessonBoxModel> {
  @override
  final int typeId = 1;

  @override
  LessonBoxModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonBoxModel(
      id: fields[0] as int,
      createdAt: fields[1] as String,
      title: fields[2] as String,
      questionType: fields[3] as String,
      description: fields[4] as String,
      content: fields[5] as String,
      objective: fields[6] as String,
      mediaUrl: fields[7] as String,
      week: fields[8] as String,
      type: fields[9] as String,
      answered: (fields[10] as List).cast<dynamic>(),
      mediaType: fields[11] as String,
      questions: fields[12] as String,
      questionCount: fields[13] as int,
      percentage: fields[14] as int,
      lastQuestionAnswered: fields[15] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LessonBoxModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.questionType)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.content)
      ..writeByte(6)
      ..write(obj.objective)
      ..writeByte(7)
      ..write(obj.mediaUrl)
      ..writeByte(8)
      ..write(obj.week)
      ..writeByte(9)
      ..write(obj.type)
      ..writeByte(10)
      ..write(obj.answered)
      ..writeByte(11)
      ..write(obj.mediaType)
      ..writeByte(12)
      ..write(obj.questions)
      ..writeByte(13)
      ..write(obj.questionCount)
      ..writeByte(14)
      ..write(obj.percentage)
      ..writeByte(15)
      ..write(obj.lastQuestionAnswered);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonBoxModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
