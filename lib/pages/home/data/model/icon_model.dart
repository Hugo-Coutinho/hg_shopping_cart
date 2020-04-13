import 'package:flutter/cupertino.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';

class IconModel extends IconEntity {
  IconModel({@required String name, @required String url})
      : super(name: name, url: url);

  factory IconModel.fromJson(Map<String, dynamic> json) {
    final name = json['description'];

    final images = json['images'];
    if (images != null) {
      final png = images['png'];
      if (png != null) {
        final png512 = png['512'];
        if (png512 != null) {
          return IconModel(name: name, url: png512);
        }
      }
    }
    return null;
  }
}
