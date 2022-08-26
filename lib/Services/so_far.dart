import 'package:http/http.dart' as http;
import 'dart:convert';

class SoFar
{
  String groupid, password;
  String resource;
  SoFar({required this.groupid,required this.password, required this.resource});

  Future<Map> get() async
  {
    Map result={};
    Map<String,String> header={"groupId":groupid,"password":password};
    http.Response response= await http.get(Uri.parse("https://Doubles-generator.arunn5.repl.co/$resource"),headers: header);
    if(response.statusCode==200)
      {
        // Map resul=jsonDecode(response.body);
        // print(resul);
        result["result"]="OK";
      }
    else{
      result["result"]="Failed";
    }
    return result;
  }
}