import 'dart:convert';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import 'package:http/http.dart' as http;

abstract class IconRemoteDataSource {
  Future<List<IconModel>> getIcons();
}

class IconRemoteDataSourceImpl extends IconRemoteDataSource {
  final http.Client client;

  IconRemoteDataSourceImpl(this.client);

  @override
  Future<List<IconModel>> getIcons() async {
    final response = await _getIconsResponse();
    final jsonIcons = response.statusCode == 200 ? _getIconsJsonData(response) : List<dynamic>();
    return _getIconModelsByJson(jsonIcons);
  }

  List<IconModel> _getIconModelsByJson(List<dynamic> jsonData) {
    return jsonData.map((element) => IconModel.fromJson(element)).toList();
  }

  List<dynamic> _getIconsJsonData(http.Response response) {
      return List<dynamic>.from(json.decode(response.body)['data']);
  }

  Future<http.Response> _getIconsResponse() {
    return http.get(Uri.encodeFull(Constant.getIconsUrl),
        headers: {Constant.authorization: Constant.token});
  }
}
