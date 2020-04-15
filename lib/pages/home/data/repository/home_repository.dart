import 'package:hg_shopping_cart/pages/home/data/data_sources/icon_remote_data_source.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';

abstract class HomeRepository {
  Future<List<IconModel>> getIcons();
}

class HomeRepositoryImpl implements HomeRepository {
  final IconRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<IconModel>> getIcons() async {
    return await remoteDataSource.getIcons();
  }
}
