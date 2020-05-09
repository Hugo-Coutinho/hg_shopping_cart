import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hg_shopping_cart/core/error/failure.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/home/domain/usecase/home_use_case.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_event.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_state.dart';
import 'package:dartz/dartz.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase _homeUseCase;

  HomeBloc(this._homeUseCase);

  @override
  HomeState get initialState => HomeLoadingState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
      yield HomeLoadingState();
      final eitherFailureOrItems = await _homeUseCase.loadIcons(Constant.numberPage);
      yield* _eitherLoadedOrErrorState(eitherFailureOrItems);
  }

  Stream<HomeState> _eitherLoadedOrErrorState(Either<Failure, List<IconEntity>> failureOrItems) async* {
    yield failureOrItems.fold(
          (failure) => _mapFailure(failure),
          (items) => HomeLoadedState(items: items),
    );
  }

  HomeState _mapFailure(Failure failure) {
    return  failure is NetworkFailure ? HomeNetworkConnectionFailureState() : HomeErrorState(message: _mapFailureToMessage(failure));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return Constant.netWorkFailureMessage;
      default:
        return Constant.defaultErrorMessage;
    }
  }

  Future<Either<Failure, List<IconEntity>>> fetchingItems(int page) async {
    return await _homeUseCase.loadIcons(page);
  }

  addItem(IconEntity item) {
    _homeUseCase.didSelectItem(item);
  }

  Future<List<IconEntity>> getAmountShoppingCart() {
    return _homeUseCase.amountItemShoppingCart();
  }
}
