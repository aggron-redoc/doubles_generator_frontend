import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Add {
  String groupid, password,player,resource;
  Add(
      {required this.groupid,
        required this.password,
        required this.resource,
        required this.player});


  Future<Map> patch() async {
    Map result = {};
    Map<String, String> header = {"groupId": groupid, "password": password,"Content-Type": "application/json"};
    Map<String,String> body={'player': player};
    var encodedBody = json.encode(body);
    http.Response response = await http.patch(
        Uri.parse("https://Doubles-generator.arunn5.repl.co/$resource"),
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
