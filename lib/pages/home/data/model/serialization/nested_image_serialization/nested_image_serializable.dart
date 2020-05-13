import 'package:json_annotation/json_annotation.dart';

import '../nested_png_serialization/nested_png_serializable.dart';

part 'nested_image_serializable.g.dart';

@JsonSerializable()
class NestedImageSerializable {

  @JsonKey(name: 'png', required: true)
  NestedPngSerializable png;

  NestedImageSerializable(this.png);

  factory NestedImageSerializable.fromJson(Map<String, dynamic> json) => _$NestedImageSerializableFromJson(json);

  Map<String, dynamic> toJson() => _$NestedImageSerializableToJson(this);

}