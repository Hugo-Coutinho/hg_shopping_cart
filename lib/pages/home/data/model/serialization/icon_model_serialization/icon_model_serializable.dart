import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../nested_image_serialization/nested_image_serializable.dart';

part 'icon_model_serializable.g.dart';

@JsonSerializable()
class IconModelSerializable extends IconModel {

  @JsonKey(name: 'description', required: true)
  String name;

  @JsonKey(name: 'images', required: true)
  NestedImageSerializable image;

  @JsonKey(ignore: true)
  String url;

  @JsonKey(ignore: true)
  int amount = 1;

  IconModelSerializable(this.name, this.image): super(name: name, url: image.png.pngImage512, amount: 1) {
    this.url = image.png.pngImage512;
    this.amount = 1;
  }

  factory IconModelSerializable.fromJson(Map<String, dynamic> json) => _$IconModelSerializableFromJson(json);

  Map<String, dynamic> toJson() => _$IconModelSerializableToJson(this);

}