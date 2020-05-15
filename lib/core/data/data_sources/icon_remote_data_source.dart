import 'dart:convert';
import 'package:hg_shopping_cart/core/error/exception.dart';
import 'package:hg_shopping_cart/core/logger/logger.dart';
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
  final http.Client _client;
  final GenerateToken _generateToken;
  final _log = getLogger('icon_remote_data_source');

  IconRemoteDataSourceImpl(this._client, this._generateToken);

  @override
  Future<List<IconModel>> getIcons(int page) async {
    _log.i('Getting icons');
    try {
      _tokenValidation();
      final response = await _getIconsResponse(page);
      final jsonIcons = _validationJsonIconsByResponse(response);
      return _getIconModelsByJson(jsonIcons);
    } on ServerException {
      throw ServerException();
    }
  }

  @override
  Future<List<IconModel>> retryGetIcons(int page) async {
    _log.i('Trying again load icons after bad connection');
    await _generateToken.syncToken();
    return await this.getIcons(page);
  }

  List<dynamic> _validationJsonIconsByResponse(http.Response response) {
    final statusCode = response.statusCode;

      _log.w('Checking response status');
    if (statusCode == 200) {
      return _getIconsJsonData(response);
    }
    _log.e('Unfortunly was to a bad request with $statusCode as a status code response');
    throw ServerException();
  }

  _tokenValidation() {
    _log.w('Checking token if it is a valid one');
    if (Constant.token.isEmpty) {
      _log.e('Invalid Token');
      throw ServerException();
    }
  }

  List<IconModel> _getIconModelsByJson(List<dynamic> jsonData) {
    _log.d('Items serialization, parsing to icon model from json format');
    return jsonData.map((element) => IconModelSerializable.fromJson(element)).toList();
  }

  List<dynamic> _getIconsJsonData(http.Response response) {
    _log.d('Getting json body and mapping to a dynamic list of items');
      return List<dynamic>.from(json.decode(response.body)['data']);
  }

  Future<http.Response> _getIconsResponse(int page) {
    _log.d('Doing the icons request');
    return _client.get(Uri.encodeFull(_prepareUrlPathByPage(page)),
        headers: {Constant.authorization: Constant.token});
  }

  String _prepareUrlPathByPage(int page) {
    _log.d('Creating the endpoint path by page -> page $page');
    return Constant.getIconsUrl + "$page";
  }
}
