// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import 'package:hive/hive.dart';

//part of 'icon.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************



class IconModelAdapter extends TypeAdapter<IconModel> {
  @override
  final typeId = 1;

  @override
  IconModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return IconModel(name: fields[0] as String, url: fields[1] as String, amount: fields[2] as int);
  }

  @override
  void write(BinaryWriter writer, IconModel obj) {
    writer
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.amount);
  }
}