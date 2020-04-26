import 'package:hg_shopping_cart/core/data/data_sources/icon_local_data_source.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';

abstract class ShoppingCartRepository {
  clearItem(IconModel item);
  List<IconModel> getShoppingList();
}

class ShoppingCartRepositoryImpl extends ShoppingCartRepository {
  final IconLocalDataSource _localDataSource;

  ShoppingCartRepositoryImpl(this._localDataSource);

  @override
  clearItem(item) {
    return _localDataSource.delete(item);
  }

  @override
  List<IconModel> getShoppingList() {
    return _localDataSource.findAll();
  }
}