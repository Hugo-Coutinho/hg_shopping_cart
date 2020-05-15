import 'package:hg_shopping_cart/core/data/data_sources/icon_local_data_source.dart';
import 'package:hg_shopping_cart/core/logger/logger.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';

abstract class ShoppingCartRepository {
  clearItem(IconModel item);
  clearAllFromDatabase();
  Future<List<IconModel>> getShoppingList();
}

class ShoppingCartRepositoryImpl extends ShoppingCartRepository {
  final IconLocalDataSource _localDataSource;
  final _log = getLogger('shopping_cart_repository');

  ShoppingCartRepositoryImpl(this._localDataSource);

  @override
  clearItem(item) {
    final itemName = item.name;
    _log.i('delete $itemName');
    return _localDataSource.delete(item);
  }

  @override
  Future<List<IconModel>> getShoppingList() {
    _log.i('find all items');
    return _localDataSource.findAll();
  }

  @override
  clearAllFromDatabase() {
    _log.i('remove all items');
  return _localDataSource.deleteAll();
  }
}