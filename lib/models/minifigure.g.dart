// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minifigure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MinifigureAdapter extends TypeAdapter<Minifigure> {
  @override
  final int typeId = 0;

  @override
  Minifigure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Minifigure(
      name: fields[0] as String,
      collection: fields[1] as String,
      imagePath: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Minifigure obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.collection)
      ..writeByte(2)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MinifigureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
