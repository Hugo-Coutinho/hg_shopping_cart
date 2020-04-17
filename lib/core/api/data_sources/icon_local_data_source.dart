import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

abstract class IconLocalDataSource {
  void add(List<IconModel> icons);
  IconModel findById(String url);
  List<IconModel> findAll();
  void delete(IconModel item);
  void deleteAll();
  void tearDown();
}

class IconLocalDataSourceImpl extends IconLocalDataSource {
  final String boxName;
  Box<IconModel> box;

  IconLocalDataSourceImpl({@required this.boxName}) {
    WidgetsFlutterBinding.ensureInitialized();
    _hiveInitialize();
  }

  void _hiveInitialize() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    this.box = await Hive.openBox(boxName);
  }

  @override
  void add(List<IconModel> icons) {
    icons.forEach((currentItem) {
      final IconModel itemFromBox = box.get(currentItem.url);
      itemFromBox != null ? _incrementAmount(currentItem) : _insertItem(currentItem);
    });
  }

  @override
  void delete(IconModel item) {
    final IconModel itemFromBox = box.get(item.url);
    itemFromBox != null ? _decrementAmount(item) : _insertItem(item);
  }

  @override
  IconModel findById(String url) {
    return box.values.toList().firstWhere((currentItem) => currentItem.url == url, orElse: () => null);
  }

  @override
  List<IconModel> findAll() {
    return box.values.toList();
  }

  @override
  void deleteAll() {
    box.clear();
  }

  @override
  void tearDown() {
    Hive.close();
  }

  void _incrementAmount(IconModel item) {
    item.amount += 1;
    item.save();
  }

  void _decrementAmount(IconModel item) {
    item.amount > 1 ? _decrementAmountAndUpdateItem(item) : _removeItem(item);
  }

  void _decrementAmountAndUpdateItem(IconModel item) {
     item.amount -= 1;
     item.save();
  }

  void _removeItem(IconModel item) {
  item.delete();
  }

  void _insertItem(IconModel item) {
    box.put(item.url, item);
  }
}