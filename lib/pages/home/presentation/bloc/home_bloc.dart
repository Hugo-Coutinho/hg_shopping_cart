import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hg_shopping_cart/core/error/failure.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/home/domain/usecase/HomeUseCase.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_event.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_state.dart';
import 'package:dartz/dartz.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase homeUsecase;

  HomeBloc(this.homeUsecase);

  @override
  HomeState get initialState => HomeLoadingState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
      yield HomeLoadingState();
      final eitherFailureOrItems = await homeUsecase.loadIcons(Constant.numberPage);
      yield* _eitherLoadedOrErrorState(eitherFailureOrItems);
  }

  Stream<HomeState> _eitherLoadedOrErrorState(Either<Failure, List<IconEntity>> failureOrItems) async* {
    yield failureOrItems.fold(
          (failure) => HomeErrorState(message: _mapFailureToMessage(failure)),
          (items) => HomeLoadedState(items: items),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return "Please, verify your internet connection";
      default:
        return "something wrong";
    }
  }

  Future<Either<Failure, List<IconEntity>>> fetchingItems(int page) async {
    return await homeUsecase.loadIcons(page);
  }
}
