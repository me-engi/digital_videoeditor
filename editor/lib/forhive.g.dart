// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forhive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 0;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      name: fields[0] as String,
      quantity: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
    };
