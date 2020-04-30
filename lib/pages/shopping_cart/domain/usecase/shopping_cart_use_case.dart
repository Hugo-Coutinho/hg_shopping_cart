import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/data/repository/shopping_cart_repository.dart';


abstract class ShoppingCartUseCase {
  clearItem(IconEntity item);
  Future<List<IconEntity>> getShoppingList();
}

class ShoppingCartUseCaseImpl extends ShoppingCartUseCase {
final ShoppingCartRepository _repository;

ShoppingCartUseCaseImpl(this._repository);

  @override
  clearItem(IconEntity item) {
    return _repository.clearItem(item);
  }

  @override
  Future<List<IconEntity>> getShoppingList() {
    return _repository.getShoppingList();
  }
}