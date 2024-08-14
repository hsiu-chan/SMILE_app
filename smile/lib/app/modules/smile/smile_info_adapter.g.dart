// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smile_info_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SmileInfoAdapter extends TypeAdapter<SmileInfo> {
  @override
  final int typeId = 0;

  @override
  SmileInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SmileInfo(
      mouthPoints: (fields[0] as List)
          .map((dynamic e) => (e as List).cast<double>())
          .toList(),
      toothBoxes: (fields[1] as List)
          .map((dynamic e) => (e as List).cast<double>())
          .toList(),
      toothClasses: (fields[2] as List).cast<String>(),
      h2w: fields[3] as double,
      mostPosteriorMaxillaryTeethVisible: fields[4] as int,
      arcRatio: fields[5] as double,
      buccalCorridor: fields[6] as double,
      maxillaryTeethExposure: fields[7] as double,
      path: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SmileInfo obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.mouthPoints)
      ..writeByte(1)
      ..write(obj.toothBoxes)
      ..writeByte(2)
      ..write(obj.toothClasses)
      ..writeByte(3)
      ..write(obj.h2w)
      ..writeByte(4)
      ..write(obj.mostPosteriorMaxillaryTeethVisible)
      ..writeByte(5)
      ..write(obj.arcRatio)
      ..writeByte(6)
      ..write(obj.buccalCorridor)
      ..writeByte(7)
      ..write(obj.maxillaryTeethExposure)
      ..writeByte(8)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmileInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
