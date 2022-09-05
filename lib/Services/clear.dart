import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Clear {
  String groupid, password;
  String resource;
  Clear(
      {required this.groupid,
      required this.password,
      required this.resource});
  Future<Map> patch() async {
    Map result = {};
    Map<String, String> header = {"groupId": groupid, "password": password};
    http.Response response = await http.patch(
        Uri.parse("https://Doubles-generator.arunn5.repl.co/$resource"),
        headers: header);
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
