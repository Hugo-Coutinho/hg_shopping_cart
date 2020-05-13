import  'package:flutter/foundation.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hive/hive.dart';

part 'icon_model.g.dart';

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
}
