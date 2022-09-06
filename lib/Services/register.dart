import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../flutter_secret.dart';

class Register {
  String groupid, password;
  String resource;
  List<String> players;
  Register(
      {required this.groupid,
      required this.password,
      required this.players,
      required this.resource});
  Future<Map> post() async {
    Map result = {};
    Map<String, String> header = {
      "groupId": groupid,
      "password": password,
      "Content-Type": "application/json"
    };
    Map<String, List<String>> body = {"players": players};
    var encodedBody = json.encode(body);
    http.Response response = await http.post(
        Uri.parse(url(resource)),
        headers: header,
        body: encodedBody);
    if (response.statusCode == 200) {
      result["result"] = "OK";
    } else {
      result["result"] = "Failed";
    }
    if (kDebugMode) {
      print(response.body);
    }
    return result;
  }
}
