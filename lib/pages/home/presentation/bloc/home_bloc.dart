import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hg_shopping_cart/core/error/failure.dart';
import 'package:hg_shopping_cart/core/logger/logger.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/home/domain/usecase/home_use_case.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_event.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_state.dart';
import 'package:dartz/dartz.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase _homeUseCase;
  final StreamController<List<IconEntity>> _homeStream;
  final _log = getLogger('home_bloc');
  List<IconEntity> itemList;

  Sink<List<IconEntity>> get homeStreamInput => _homeStream.sink;
  Stream<List<IconEntity>> get homeStreamOutput => _homeStream.stream;


  HomeBloc(this._homeUseCase, this._homeStream, this.itemList);

  @override
  HomeState get initialState => HomeLoadingState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    _log.i('mapping user event to the correct state -> event $event');
    yield HomeLoadingState();
    yield* (event is HomeDidLoadEvent) ? _mapDidLoadEventToState(event.didHomeRetryConnection()) : "";
  }

  Stream<HomeState> _mapDidLoadEventToState(bool didRetryConnection) async* {
    yield* didRetryConnection ? _retryGenerateTokenAndMapItemsToState() : _mapItemsToState();

  }

  Stream<HomeState> _retryGenerateTokenAndMapItemsToState() async* {
    _log.w('retry event, retrying remote items again');
    final eitherFailureOrItems = await _homeUseCase.retryLoadIcons(Constant.pageONe);
    yield* _eitherLoadedOrErrorState(eitherFailureOrItems);
  }

  Stream<HomeState> _mapItemsToState() async* {
    _log.w('trying to get remote items');
    final eitherFailureOrItems = await _homeUseCase.loadIcons(Constant.pageONe);
    yield* _eitherLoadedOrErrorState(eitherFailureOrItems);
  }


  Stream<HomeState> _eitherLoadedOrErrorState(Either<Failure, List<IconEntity>> failureOrItems) async* {
    yield failureOrItems.fold(
          (failure) {
            _log.e('after error response, mapping error to the correct state');
            return _mapFailure(failure);
          },
          (items) {
            _log.d('after success response, updating the item stream');
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
    _log.d('hey home case, bring to me items by request please');
    return await _homeUseCase.loadIcons(page);
  }

  addItem(IconEntity item) {
    final itemName = item.name;
    _log.d('hey home case, save $itemName item to the cart for me please');
    _homeUseCase.didSelectItem(item);
  }

  Future<List<IconEntity>> getAmountShoppingCart() {
    _log.d('get all shopping cart');
    return _homeUseCase.getAllShoppingCartItems();
  }

  List<IconEntity> getFilteredItems(TextEditingController filter) {
    return _homeUseCase.getFilteredItems(filter.text, itemList);
  }

  disposeLocalStorage() {
    _log.d('disposing local storage');
    _homeUseCase.disposeLocalStorage();
  }

  disposeStream() {
    _log.d('disposing streams');
    _homeStream.close();
    homeStreamInput.close();
  }
}
