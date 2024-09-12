import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forhive.g.dart';

@HiveType(typeId: 0) // Assign a unique typeId for Hive
@JsonSerializable()
class Item {
  @HiveField(0) // Assign a unique index for each field in Hive
  final String name;

  @HiveField(1)
  final int quantity;

  Item({required this.name, required this.quantity});

  // JSON serialization
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
