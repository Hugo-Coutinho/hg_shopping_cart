import 'package:dartz/dartz.dart';
import 'package:hg_shopping_cart/core/error/failure.dart';
import 'package:hg_shopping_cart/pages/home/data/repository/home_repository.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';

abstract class HomeUseCase {
  didSelectItem(IconEntity item);
  Future<Either<Failure, List<IconEntity>>> loadIcons(int page);
  Future<Either<Failure, List<IconEntity>>> retryLoadIcons(int page);
  Future<List<IconEntity>> amountItemShoppingCart();
  List<IconEntity> getFilteredItems(String search, List<IconEntity> items);
}

class HomeUseCaseImpl extends HomeUseCase {
  final HomeRepository repository;

  HomeUseCaseImpl(this.repository);

  @override
   didSelectItem(IconEntity item) async => repository.addItemToCart(item);

  @override
  Future<Either<Failure, List<IconEntity>>> loadIcons(int page) => repository.getIcons(page);

  @override
  Future<List<IconEntity>> amountItemShoppingCart() => repository.findAllFromLocalDataBase();

  @override
  Future<Either<Failure, List<IconEntity>>> retryLoadIcons(int page) => repository.retryGetIcons(page);

  @override
  List<IconEntity> getFilteredItems(String search, List<IconEntity> items) {
    return search.isNotEmpty ?
    items.where((currentItem) => currentItem.name.toLowerCase().contains(search.toLowerCase())).toList()
        : items;
  }
}
