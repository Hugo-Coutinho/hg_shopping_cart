import 'package:hg_shopping_cart/core/data/data_sources/icon_local_data_source.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';

abstract class ShoppingCartRepository {
  List<IconModel> findAllShoppingCart();
  clearItem(IconModel item);
}

class ShoppingCartRepositoryImpl extends ShoppingCartRepository {
  final IconLocalDataSource localDataSource;

  ShoppingCartRepositoryImpl(this.localDataSource);

  @override
  clearItem(IconModel item) {
    localDataSource.delete(item);
  }

  @override
  List<IconModel> findAllShoppingCart() {
    return localDataSource.findAll();
  }
}
