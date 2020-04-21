import 'package:equatable/equatable.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeFindItemEvent extends HomeEvent {
  final String itemName;

  HomeFindItemEvent(this.itemName);

  @override
  List<Object> get props => [itemName];
}

class HomeDidSelectItemEvent extends HomeEvent {
  final IconModel item;

  HomeDidSelectItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

class HomeToListItemsEvent extends HomeEvent {

  HomeToListItemsEvent();

  @override
  List<Object> get props => [];
}
