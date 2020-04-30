import 'package:dartz/dartz.dart';
import 'package:hg_shopping_cart/core/error/failure.dart';
import 'package:hg_shopping_cart/pages/home/data/repository/home_repository.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';

abstract class HomeUseCase {
  didSelectItem(IconEntity item);
  Future<Either<Failure, List<IconEntity>>> loadIcons(int page);
  Future<List<IconEntity>> amountItemShoppingCart();
}

class HomeUseCaseImpl extends HomeUseCase {
  final HomeRepository repository;

  HomeUseCaseImpl(this.repository);

  @override
   didSelectItem(IconEntity item) async {
    return repository.addItemToCart(item);
  }

  @override
  Future<Either<Failure, List<IconEntity>>> loadIcons(int page) {
    return repository.getIcons(page);
  }

  @override
  Future<List<IconEntity>> amountItemShoppingCart() {
    return repository.findAllFromLocalDataBase();
  }
}
