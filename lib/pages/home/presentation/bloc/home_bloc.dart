import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hg_shopping_cart/core/error/failure.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/home/domain/usecase/home_use_case.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_event.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_state.dart';
import 'package:dartz/dartz.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase _homeUseCase;
  final StreamController<List<IconEntity>> _homeStream;
  List<IconEntity> itemList;

  Sink<List<IconEntity>> get homeStreamInput => _homeStream.sink;
  Stream<List<IconEntity>> get homeStreamOutput => _homeStream.stream;


  HomeBloc(this._homeUseCase, this._homeStream, this.itemList);

  @override
  HomeState get initialState => HomeLoadingState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    yield HomeLoadingState();
    yield* (event is HomeDidLoadEvent) ? _mapDidLoadEventToState(event.didHomeRetryConnection()) : "";
  }

  Stream<HomeState> _mapDidLoadEventToState(bool didRetryConnection) async* {
    yield* didRetryConnection ? _retryGenerateTokenAndMapItemsToState() : _mapItemsToState();

  }

  Stream<HomeState> _retryGenerateTokenAndMapItemsToState() async* {
    final eitherFailureOrItems = await _homeUseCase.retryLoadIcons(Constant.pageONe);
    yield* _eitherLoadedOrErrorState(eitherFailureOrItems);
  }

  Stream<HomeState> _mapItemsToState() async* {
    final eitherFailureOrItems = await _homeUseCase.loadIcons(Constant.pageONe);
    yield* _eitherLoadedOrErrorState(eitherFailureOrItems);
  }


  Stream<HomeState> _eitherLoadedOrErrorState(Either<Failure, List<IconEntity>> failureOrItems) async* {
    yield failureOrItems.fold(
          (failure) => _mapFailure(failure),
          (items) {
            itemList += items;
            homeStreamInput.add(items);
            return HomeLoadedState(items: items);
          },
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

  List<IconEntity> getFilteredItems(TextEditingController filter) {
    return _homeUseCase.getFilteredItems(filter.text, itemList);
  }
}
