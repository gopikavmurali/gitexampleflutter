import 'dart:convert';

import 'package:api_example/marchapi/user_model.dart';
import 'package:http/http.dart' as http;


class UserApi
{
  Future<List<User>> getuser() async
  {
    var users= await http.get(Uri.parse("https://dummyjson.com/users"));
    if(users.statusCode==200)
      {
        var json = jsonDecode(users.body);
        var response = UserModel.fromJson(json);
        var userlist = response.users;
        return userlist;
      }
    else
      {
        throw Exception("erro");
      }
  }
}

