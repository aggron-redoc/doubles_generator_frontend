import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Randomize {
  String groupid, password;
  String resource;
  Randomize(
      {required this.groupid, required this.password, required this.resource});
  Future<Map> patch() async
  {
    Map result = {};
    Map<String, String> header = {"groupId": groupid, "password": password};
    http.Response response = await http.patch(
        Uri.parse("https://Doubles-generator.arunn5.repl.co/$resource"),
        headers: header);
    if (response.statusCode == 200) {
      List matchUps = json.decode(json.decode(response.body));
      if (kDebugMode) {
        print(matchUps);
      }
      if(matchUps.isEmpty)
      {
        result["result"]="Empty";
        return result;
      }
      result["matchUps"]=matchUps;
      result["result"] = "OK";
    } else {
      result["result"] = "Failed";
    }
    return result;
  }
}
