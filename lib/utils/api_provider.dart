import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:pagination/utils/base_constant.dart';
import 'package:pagination/utils/custom_exception.dart';

class ApiProvider {
  final String _baseUrl = BaseConstant.BASE_URL;

  Future<dynamic> httpMethod(
      String method, String url, var requestBody, String token) async {

    var response;
    try {
      if (method == 'get') {
        response = await http.get(Uri.parse(_baseUrl + url),
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      } else if (method == 'post') {
        response = await http.post(
          Uri.parse(_baseUrl + url),
          body: jsonEncode(requestBody),
          //headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        );
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return _response(response);
  }

  Future<dynamic> httpMethodWithoutToken(String method, String url, var requestBody) async {
    var response;
    try {
      if (method == 'get') {
        response = await http.get(Uri.parse(_baseUrl + url));
      } else if (method == 'post') {
        response = await http.post(
          _baseUrl + url,
          body: requestBody,
        );
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return _response(response);
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
        break;
      case 400:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
        break;
      case 401:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        throw UnauthorisedException(response.body.toString());
        return responseJson;
      case 403:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        throw UnauthorisedException(response.body.toString());
        return responseJson;
      case 404:
      case 422:
      case 500:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
        break;
      default:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        throw FetchDataException(
            'Error : ${response.statusCode}\n$responseJson');
    }
  }
}
