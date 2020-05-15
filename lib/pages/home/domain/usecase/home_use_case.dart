import 'package:dartz/dartz.dart';
import 'package:hg_shopping_cart/core/error/failure.dart';
import 'package:hg_shopping_cart/core/logger/logger.dart';
import 'package:hg_shopping_cart/pages/home/data/repository/home_repository.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';

abstract class HomeUseCase {
  didSelectItem(IconEntity item);
  Future<Either<Failure, List<IconEntity>>> loadIcons(int page);
  Future<Either<Failure, List<IconEntity>>> retryLoadIcons(int page);
  Future<List<IconEntity>> getAllShoppingCartItems();
  List<IconEntity> getFilteredItems(String search, List<IconEntity> items);
  disposeLocalStorage();
}

class HomeUseCaseImpl extends HomeUseCase {
  final HomeRepository _repository;
  final _log = getLogger('home_use_case');

  HomeUseCaseImpl(this._repository);

  @override
   didSelectItem(IconEntity item) async => _repository.addItemToCart(item);

  @override
  Future<Either<Failure, List<IconEntity>>> loadIcons(int page) => _repository.getIcons(page);

  @override
  Future<List<IconEntity>> getAllShoppingCartItems() => _repository.findAllFromLocalDataBase();

  @override
  Future<Either<Failure, List<IconEntity>>> retryLoadIcons(int page) => _repository.retryGetIcons(page);

  @override
  List<IconEntity> getFilteredItems(String search, List<IconEntity> items) {
    if (search.isNotEmpty) {
      _log.i('filtering stream items by user search -> $search');
      return items.where((currentItem) => currentItem.name.toLowerCase().contains(search.toLowerCase())).toList();
    } else {
      return items;
    }
  }

  @override
  disposeLocalStorage() {
    _log.i('disposing local storage');
    _repository.disposeLocalStorage();
  }
}
