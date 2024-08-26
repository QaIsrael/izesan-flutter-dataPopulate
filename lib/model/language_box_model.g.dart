// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_box_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LanguageBoxModelAdapter extends TypeAdapter<LanguageBoxModel> {
  @override
  final int typeId = 0;

  @override
  LanguageBoxModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LanguageBoxModel(
      id: fields[0] as int,
      name: fields[1] as String,
      imagePath: fields[2] as String,
      status: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LanguageBoxModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageBoxModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
