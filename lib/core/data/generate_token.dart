import 'dart:convert';
import 'package:hg_shopping_cart/core/logger/logger.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:http/http.dart' as http;

abstract class GenerateToken {
  Future<void> syncToken();
}

class GenerateTokenImpl extends GenerateToken {
  final http.Client client;
  final _log = getLogger('generate_token');

  GenerateTokenImpl(this.client);

  @override
  Future<void> syncToken() async {
    _log.w('running authentication');
    final response = await _getIconsResponse();
    return _setupTokenByResponse(response);
  }

  _setupTokenByResponse(http.Response response) {
    if (response.statusCode == 200) {
      final token = Constant.bearer + json.decode(response.body)['data']['token'];
      _log.d('successfuly token getted -> $token');
      Constant.token = token;
    } else {
      final badStatusCode = response.statusCode;
      _log.e('bad authentication, $badStatusCode status code');
      Constant.token = "";
    }
    return Future.value();
  }

  Future<http.Response> _getIconsResponse() {
    return http.post(Uri.encodeFull(Constant.authenticationUrl), headers: {
      "Accept": Constant.applicationJson
    }, body: {
      "apikey": Constant.apiKey
    });
  }
}
