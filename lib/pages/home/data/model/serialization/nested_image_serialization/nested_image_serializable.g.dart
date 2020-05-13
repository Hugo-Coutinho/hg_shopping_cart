// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nested_image_serializable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NestedImageSerializable _$NestedImageSerializableFromJson(
    Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['png']);
  return NestedImageSerializable(
    json['png'] == null
        ? null
        : NestedPngSerializable.fromJson(json['png'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NestedImageSerializableToJson(
        NestedImageSerializable instance) =>
    <String, dynamic>{
      'png': instance.png,
    };
