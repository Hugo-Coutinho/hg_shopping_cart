import 'dart:convert';
import 'package:hg_shopping_cart/core/util/constant/Constant.dart';
import 'package:http/http.dart' as http;

abstract class GenerateToken {
  Future<void> syncToken();
}

class GenerateTokenImpl extends GenerateToken {
  final http.Client client;

  GenerateTokenImpl(this.client);

  @override
  Future<void> syncToken() async {
    final response = await _getIconsResponse();
    Future.value(response.statusCode == 200 ? Constant.token = Constant.bearer + json.decode(response.body)['data']['token'] : Constant.token = "");
  }

  Future<http.Response> _getIconsResponse() {
    return http.post(Uri.encodeFull(Constant.authenticationUrl), headers: {
      "Accept": "application/json"
    }, body: {
      "apikey": Constant.apiKey
    });
  }
}
