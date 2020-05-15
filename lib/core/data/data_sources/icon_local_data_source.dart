import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hg_shopping_cart/core/error/exception.dart';
import 'package:hg_shopping_cart/core/logger/logger.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

abstract class IconLocalDataSource {
  add(List<IconModel> icons);
  IconModel findById(String url);
  Future<List<IconModel>> findAll();
  delete(IconModel item);
  deleteAll();
  tearDown();
}

class IconLocalDataSourceImpl extends IconLocalDataSource {
  final String boxName;
  Box<IconModel> _box;
  final _log = getLogger('icon_local_data_source');

  IconLocalDataSourceImpl({@required this.boxName}) {
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  add(List<IconModel> icons) {
    _log.i('Saving items to the Hive.');
    icons.forEach((currentItem) {
      final IconModel itemFromBox = _box.get(currentItem.url);
      itemFromBox != null ? _incrementAmount(currentItem) : _insertItem(currentItem);
    });
  }

  @override
  delete(IconModel item) {
    _log.i('Looking foward the item from local database.');
    final IconModel itemFromBox = _box.get(item.url);
    _log.i('Deleting the item, or just decrement your amount.');
    itemFromBox != null ? _decrementAmount(item) : _removeItem(item);
  }

  @override
  IconModel findById(String url) {
    return _box.values.toList().firstWhere((currentItem) => currentItem.url == url, orElse: () => throw CacheException());
  }

  @override
  Future<List<IconModel>> findAll() async {
    await _checkHiveSetup();
    _log.i('Returning all items from the Hive.');
   return _box.values.toList();
  }

  @override
  deleteAll() {
    _log.w('Erasing all from local database Hive.');
    _box.clear();
  }

  @override
  tearDown() {
    _log.w('Closing all the Hive boxes.');
    Hive.close();
  }

  Future _checkHiveSetup() async {
    _log.d('Checking Hive`s box instance');
    if (_box != null) {
      return Future;
    }
    await _hiveInitialization();
  }

  Future _hiveInitialization() async {
    _log.w('Getting application directory to init the hive');
    final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    _log.w('Hive init');
    Hive.init(appDocumentDirectory.path);
    _log.w('Creating hive adapter');
    Hive.registerAdapter(IconModelAdapter());
    _log.w('Opening the hive box');
    this._box = await Hive.openBox(boxName);
  }

   _incrementAmount(IconModel item) {
     _log.d('Incrementing item count');
    item.amount += 1;
  _insertItem(item);
  }

   _decrementAmount(IconModel item) {
     _log.d('Decrementing item count');
    item.amount > 1 ? _decrementAmountAndUpdateItem(item) : _removeItem(item);
  }

   _decrementAmountAndUpdateItem(IconModel item) {
     _log.d('updating on Hive the new item amount');
     item.amount -= 1;
     _insertItem(item);
  }

   _removeItem(IconModel item) {
     _log.d('Actualling removing the item');
    _box.delete(item.url);
  }

  _insertItem(IconModel item) {
    _log.d('Saving new item to the shopping list cart local database');
    _box.put(item.url, item);
  }
}