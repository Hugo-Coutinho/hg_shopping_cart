import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ShoppingCartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ShoppingCartDefaultEvent extends ShoppingCartEvent { }
