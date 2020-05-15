import 'package:hg_shopping_cart/core/logger/logger.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/data/repository/shopping_cart_repository.dart';


abstract class ShoppingCartUseCase {
  clearItem(IconEntity item);
  clearAll();
  Future<List<IconEntity>> getShoppingList();
}

class ShoppingCartUseCaseImpl extends ShoppingCartUseCase {
final ShoppingCartRepository _repository;
final _log = getLogger('shopping_cart_use_case');

ShoppingCartUseCaseImpl(this._repository);

  @override
  clearItem(IconEntity item) {
    _log.i('clear item');
    return _repository.clearItem(item);
  }

  @override
  Future<List<IconEntity>> getShoppingList() {
    _log.i('get shopping list');
    return _repository.getShoppingList();
  }

  @override
  clearAll() {
    _log.i('kill them all');
    _repository.clearAllFromDatabase();
  }
}