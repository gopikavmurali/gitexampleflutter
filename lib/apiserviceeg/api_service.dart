import 'dart:convert';

import 'package:api_example/apiserviceeg/model_class.dart';
import 'package:http/http.dart' as http;

class ApiUser
{
   Future<List<User>> getuserlist() async
   {
     var usersres = await http.get(Uri.parse("https://dummyjson.com/users"));
     if(usersres.statusCode == 200)
       {
         var json = jsonDecode(usersres.body);
         var response = UserDetailModel.fromJson(json);
         var listofuser = response.users;
         return listofuser;
       }
     else
       {
         throw Exception("error");
       }
   }
}