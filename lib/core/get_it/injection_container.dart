import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:hg_shopping_cart/core/data/data_sources/icon_local_data_source.dart';
import 'package:hg_shopping_cart/core/data/data_sources/icon_remote_data_source.dart';
import 'package:hg_shopping_cart/core/data/generate_token.dart';
import 'package:hg_shopping_cart/core/network/network_info.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/pages/home/data/repository/home_repository.dart';
import 'package:hg_shopping_cart/pages/home/domain/usecase/HomeUseCase.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hg_shopping_cart/pages/shopping_cart/data/repository/shooping_cart_repository.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  _injectToExternalLayer();
  _injectToCore();
  _injectToDataSourceLayer();
  _injectToRepositoryLayer();
  _injectToUseCaseLayer();
  _injectToPresentationLayer();
}

_injectToDataSourceLayer() {
  locator.registerLazySingleton<IconRemoteDataSource>(
      () => IconRemoteDataSourceImpl(locator()));
  locator
      .registerLazySingleton<GenerateToken>(() => GenerateTokenImpl(locator()));
  locator.registerLazySingleton<IconLocalDataSource>(
      () => IconLocalDataSourceImpl(boxName: Constant.box));
}

_injectToRepositoryLayer() {
  locator.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(locator(), locator(), locator()));
  locator.registerLazySingleton<ShoppingCartRepository>(
    () => ShoppingCartRepositoryImpl(locator()),
  );
}

_injectToUseCaseLayer() {
  locator.registerLazySingleton<HomeUseCase>(() => HomeUseCaseImpl(locator()));
}

_injectToExternalLayer() {
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}

_injectToCore() {
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));
}

_injectToPresentationLayer() {
  locator.registerFactory(() => HomeBloc(locator()));
}
