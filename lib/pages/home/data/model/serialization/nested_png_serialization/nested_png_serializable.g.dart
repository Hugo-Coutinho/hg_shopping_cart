// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nested_png_serializable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NestedPngSerializable _$NestedPngSerializableFromJson(
    Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['512']);
  return NestedPngSerializable(
    json['512'] as String,
  );
}

Map<String, dynamic> _$NestedPngSerializableToJson(
        NestedPngSerializable instance) =>
    <String, dynamic>{
      '512': instance.pngImage512,
    };
