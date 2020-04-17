import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class IconEntity extends HiveObject {
  String name;
  String url;
  int amount;

  IconEntity({
    @required this.name,
    @required this.url,
    @required this.amount,
  });
}
