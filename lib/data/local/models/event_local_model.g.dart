// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalEventAdapter extends TypeAdapter<LocalEvent> {
  @override
  final int typeId = 0;

  @override
  LocalEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalEvent(
      id: fields[0] as String,
      title: fields[1] as String,
      date: fields[2] as DateTime,
      calendarId: fields[3] as String?,
      deviceEventId: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalEvent obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.calendarId)
      ..writeByte(4)
      ..write(obj.deviceEventId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
