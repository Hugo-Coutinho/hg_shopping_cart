import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ShoppingCartState extends Equatable {
  @override
  List<Object> get props => [];
}

class ShoppingCartEmptyState extends ShoppingCartState {}

class ShoppingCartDefaultState extends ShoppingCartState {}
