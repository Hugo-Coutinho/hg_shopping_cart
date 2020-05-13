import 'package:json_annotation/json_annotation.dart';

part 'nested_png_serializable.g.dart';

@JsonSerializable()
class NestedPngSerializable {

  @JsonKey(name: '512', required: true)
  String pngImage512;

  NestedPngSerializable(this.pngImage512);

  factory NestedPngSerializable.fromJson(Map<String, dynamic> json) => _$NestedPngSerializableFromJson(json);

  Map<String, dynamic> toJson() => _$NestedPngSerializableToJson(this);
}