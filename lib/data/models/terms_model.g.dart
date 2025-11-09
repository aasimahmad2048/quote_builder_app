// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terms_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TermsModelAdapter extends TypeAdapter<TermsModel> {
  @override
  final int typeId = 3;

  @override
  TermsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TermsModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TermsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TermsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
