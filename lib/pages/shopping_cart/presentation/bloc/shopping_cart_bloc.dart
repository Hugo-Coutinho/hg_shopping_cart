import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/domain/usecase/shopping_cart_use_case.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/presentation/bloc/shopping_cart_event.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/presentation/bloc/shopping_cart_state.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  final ShoppingCartUseCase _shoppingCartUseCase;

  ShoppingCartBloc(this._shoppingCartUseCase);

  @override
  ShoppingCartState get initialState => ShoppingCartDefaultState();

  @override
  Stream<ShoppingCartState> mapEventToState(ShoppingCartEvent event) async* {
      yield ShoppingCartDefaultState();
  }

  clearItem(IconEntity item) {
    _shoppingCartUseCase.clearItem(item);
  }

  List<IconEntity> getList() {
    return _shoppingCartUseCase.getShoppingList();
  }
}
