import 'package:get_it/get_it.dart';
import 'package:hg_shopping_cart/core/api/data_sources/icon_local_data_source.dart';
import 'package:hg_shopping_cart/core/api/data_sources/icon_remote_data_source.dart';
import 'package:hg_shopping_cart/core/api/generate_token.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/pages/home/data/repository/home_repository.dart';
import 'package:http/http.dart' as http;

final GetIt locator = GetIt.instance;

void setupLocator() {
  _injectToDataSourceLayer();
  _injectToRepositoryLayer();
  _injectToExternalLayer();
}

_injectToDataSourceLayer() {
  locator.registerLazySingleton<IconRemoteDataSource>(
        () => IconRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<GenerateToken>(
        () => GenerateTokenImpl(locator()),
  );
  locator.registerLazySingleton<IconLocalDataSource>(
        () => IconLocalDataSourceImpl(boxName: Constant.box),
  );
}

_injectToRepositoryLayer() {
  locator.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(locator()),
  );
}

_injectToExternalLayer() {
  locator.registerLazySingleton(() => http.Client());
}
