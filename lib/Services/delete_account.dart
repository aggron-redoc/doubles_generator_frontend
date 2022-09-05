import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Delete {
  String groupid, password;
  String resource;
  Delete(
      {required this.groupid, required this.password, required this.resource});

  Future<Map> delete() async {
    Map result = {};
    Map<String, String> header = {"groupId": groupid, "password": password};
    http.Response response = await http.delete(
        Uri.parse("https://Doubles-generator.arunn5.repl.co/$resource"),
        headers: header);
    if (response.statusCode == 200) {
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