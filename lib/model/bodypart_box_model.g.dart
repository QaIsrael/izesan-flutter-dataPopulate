// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bodypart_box_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BodyPartBoxModelAdapter extends TypeAdapter<BodyPartBoxModel> {
  @override
  final int typeId = 7;

  @override
  BodyPartBoxModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BodyPartBoxModel(
      id: fields[0] as String,
      title: fields[1] as String,
      instruction: fields[2] as String,
      nextQuestionId: fields[3] as String,
      answeredType: fields[4] as String,
      mediaUrl: fields[5] as String,
      imageUrl: fields[6] as String,
      mediaType: fields[7] as String,
      options: (fields[9] as List).cast<OptionBodyPart>(),
      language: fields[10] as LanguageBodyPart,
    );
  }

  @override
  void write(BinaryWriter writer, BodyPartBoxModel obj) {
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
      ..writeByte(9)
      ..write(obj.options)
      ..writeByte(10)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyPartBoxModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OptionBodyPartAdapter extends TypeAdapter<OptionBodyPart> {
  @override
  final int typeId = 9;

  @override
  OptionBodyPart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OptionBodyPart(
      id: fields[0] as String,
      title: fields[1] as String,
      hint: fields[2] as String,
      mediaUrl: fields[3] as String,
      mediaType: fields[4] as String,
      isCorrect: fields[5] as int,
      imageUrl: fields[6] as String,
      localImageUrl: fields[7] as String,
      localMediaUrl: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OptionBodyPart obj) {
    writer
      ..writeByte(9)
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
      ..write(obj.isCorrect)
      ..writeByte(6)
      ..write(obj.imageUrl)
      ..writeByte(7)
      ..write(obj.localImageUrl)
      ..writeByte(8)
      ..write(obj.localMediaUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionBodyPartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LanguageBodyPartAdapter extends TypeAdapter<LanguageBodyPart> {
  @override
  final int typeId = 10;

  @override
  LanguageBodyPart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LanguageBodyPart(
      id: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LanguageBodyPart obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageBodyPartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
