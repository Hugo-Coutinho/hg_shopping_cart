import 'package:equatable/equatable.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {}

class HomeNetworkConnectionFailureState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<IconEntity> items;

  HomeLoadedState({@required this.items});

  @override
  List<Object> get props => [items];
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
