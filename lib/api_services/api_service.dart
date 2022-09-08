import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseURL = "http://205.134.254.135/~mobile/MtProject/public/api/";

  static const successCode = 200;
  static const unauthorisedCode = 401;

  static const String productList = "product_list.php";

  static var httpClient = http.Client();

  static Future<Map<String, dynamic>?> callPostApi(
      String endPoint, Map<String, String> params, Function? onError) async {
    Map<String, String> header = <String, String>{};

    header.addAll({
      'token':
          'eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz',
    });

    if (kDebugMode) {
      print("ApiService Post Api: ${baseURL + endPoint}");
      print("ApiService Api Header: $header");
      print("ApiService Api Params: ${jsonEncode(params)}");
    }

    var response = await http.post(Uri.parse(baseURL + endPoint),
        headers: header, body: params);

    if (kDebugMode) {
      print("ApiService Post Response Code : ${response.statusCode}");
      print("ApiService Post Response Code : ${response.body}");
    }
    if (response.statusCode == successCode) {
      return jsonDecode(response.body);
    } else if (response.statusCode == unauthorisedCode) {
      if (onError != null) {
        onError();
      }

      return null;
    } else {
      if (onError != null) {
        onError();
      }
      return null;
    }
  }
}
