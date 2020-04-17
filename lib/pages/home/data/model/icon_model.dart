import 'package:flutter/foundation.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class IconModel extends IconEntity {
  @HiveField(0)
  String name;

  @HiveField(1)
  String url;

  @HiveField(2)
  int amount;

  IconModel({@required this.name, @required this.url, @required this.amount})
      : super(name: name, url: url, amount: amount);

  factory IconModel.fromJson(Map<String, dynamic> json) {
    final name = json['description'];

    final images = json['images'];
    if (images != null) {
      final png = images['png'];
      if (png != null) {
        final png512 = png['512'];
        if (png512 != null) {
          return IconModel(name: name, url: png512, amount: 1);
        }
      }
    }
    return null;
  }
}
