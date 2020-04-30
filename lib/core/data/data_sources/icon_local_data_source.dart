import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hg_shopping_cart/core/error/exception.dart';
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

  IconLocalDataSourceImpl({@required this.boxName}) {
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  add(List<IconModel> icons) {
    icons.forEach((currentItem) {
      final IconModel itemFromBox = _box.get(currentItem.url);
      itemFromBox != null ? _incrementAmount(currentItem) : _insertItem(currentItem);
    });
  }

  @override
  delete(IconModel item) {
    final IconModel itemFromBox = _box.get(item.url);
    itemFromBox != null ? _decrementAmount(item) : _removeItem(item);
  }

  @override
  IconModel findById(String url) {
    return _box.values.toList().firstWhere((currentItem) => currentItem.url == url, orElse: () => throw CacheException());
  }

  @override
  Future<List<IconModel>> findAll() async {
    await _checkHiveSetup();
   return _box.values.toList();
  }

  @override
  deleteAll() {
    _box.clear();
  }

  @override
  tearDown() {
    Hive.close();
  }

  Future _checkHiveSetup() async {
    if (_box != null) {
      return Future;
    }
    await _hiveInitialization();
  }

  Future _hiveInitialization() async {
    final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(IconModelAdapter());
    this._box = await Hive.openBox(boxName);
  }

   _incrementAmount(IconModel item) {
    item.amount += 1;
  _insertItem(item);
  }

   _decrementAmount(IconModel item) {
    item.amount > 1 ? _decrementAmountAndUpdateItem(item) : _removeItem(item);
  }

   _decrementAmountAndUpdateItem(IconModel item) {
     item.amount -= 1;
     _insertItem(item);
  }

   _removeItem(IconModel item) {
    _box.delete(item.url);
  }

  _insertItem(IconModel item) {
    _box.put(item.url, item);
  }
}