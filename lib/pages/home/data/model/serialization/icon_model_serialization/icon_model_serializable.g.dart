// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_model_serializable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IconModelSerializable _$IconModelSerializableFromJson(
    Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['description', 'images']);
  return IconModelSerializable(
    json['description'] as String,
    json['images'] == null
        ? null
        : NestedImageSerializable.fromJson(
            json['images'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$IconModelSerializableToJson(
        IconModelSerializable instance) =>
    <String, dynamic>{
      'description': instance.name,
      'images': instance.image,
    };
