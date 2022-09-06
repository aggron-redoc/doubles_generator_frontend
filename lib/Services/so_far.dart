import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../flutter_secret.dart';

class SoFar {
  String groupid, password;
  String resource;
  SoFar(
      {required this.groupid, required this.password, required this.resource});

  Future<Map> get() async {
    Map result = {};
    Map<String, String> header = {"groupId": groupid, "password": password};
    http.Response response = await http.get(
        Uri.parse(url(resource)),
        headers: header);
    if (response.statusCode == 200) {
      result = json.decode(json.decode(response.body));
      if (kDebugMode) {
        print(result);
      }
      result["result"] = "OK";
    } else {
      result["result"] = "Failed";
    }
    return result;
  }
}
