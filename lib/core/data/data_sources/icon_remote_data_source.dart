import 'dart:convert';
import 'package:hg_shopping_cart/core/error/exception.dart';
import 'package:hg_shopping_cart/core/get_it/injection_container.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import 'package:hg_shopping_cart/pages/home/data/model/serialization/icon_model_serialization/icon_model_serializable.dart';
import 'package:http/http.dart' as http;

import '../generate_token.dart';

abstract class IconRemoteDataSource {
  Future<List<IconModel>> getIcons(int page);
  Future<List<IconModel>> retryGetIcons(int page);
}

class IconRemoteDataSourceImpl extends IconRemoteDataSource {
  final http.Client client;

  IconRemoteDataSourceImpl(this.client);

  @override
  Future<List<IconModel>> getIcons(int page) async {
    try {
      _tokenValidation();
      final response = await _getIconsResponse(page);
      final jsonIcons = response.statusCode == 200 ? _getIconsJsonData(response) : throw ServerException();
      return _getIconModelsByJson(jsonIcons);
    } on ServerException {
      throw ServerException();
    }
  }

  @override
  Future<List<IconModel>> retryGetIcons(int page) async {
    await locator<GenerateToken>().syncToken();
    return await this.getIcons(page);
  }

  _tokenValidation() {
    return Constant.token.isEmpty ? throw ServerException() : "";
  }

  List<IconModel> _getIconModelsByJson(List<dynamic> jsonData) {
    return jsonData.map((element) => IconModelSerializable.fromJson(element)).toList();
  }

  List<dynamic> _getIconsJsonData(http.Response response) {
      return List<dynamic>.from(json.decode(response.body)['data']);
  }

  Future<http.Response> _getIconsResponse(int page) {
    return http.get(Uri.encodeFull(_prepareUrlPathByPage(page)),
        headers: {Constant.authorization: Constant.token});
  }

  String _prepareUrlPathByPage(int page) {
    return Constant.getIconsUrl + "$page";
  }
}
