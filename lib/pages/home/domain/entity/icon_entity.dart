import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class IconEntity extends Equatable {
  final String name;
  final String url;

  IconEntity({
    @required this.name,
    @required this.url,
  });

  @override
  List<Object> get props => [this.name, this.url];
}