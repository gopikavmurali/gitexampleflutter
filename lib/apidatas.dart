import 'dart:convert';

import 'package:api_example/datasDisplay.dart';
import 'package:api_example/models/Products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/Prod.dart';

class ApiFetch extends StatefulWidget {
  const ApiFetch({super.key});

  @override
  State<ApiFetch> createState() => _ApiFetchState();
}

class _ApiFetchState extends State<ApiFetch> {



   Future<List<Products>?>fetchprod() async {
     var response = await http.get(Uri.parse("https://dummyjson.com/products"));
     var jsondatas= jsonDecode(response.body);
     var ress = Prod.fromJson(jsondatas);
     var lists = ress.products;
     return lists;
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Fetch Data"),
      ),

      body: FutureBuilder(
        future: fetchprod(),
        builder: (BuildContext context, AsyncSnapshot<List<Products>?> snapshot)
        {
          if(snapshot.hasData)
            {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context,int index)
                      {
                        return ListTile(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DataDisplay(img: snapshot.data![index].images,

                              )),
                            );
                            //Navigator.push(context, MaterialPageRoute(builder: builder))
                          } ,
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage("${snapshot.data![index].thumbnail}"),
                          ),
                          title: Text("${snapshot.data![index].title}"),
                          subtitle: Text("${snapshot.data![index].description}"),
                          trailing: Text("${snapshot.data![index].price}"),
                        );
                      }
              );
            }
          else
            {
             return  Text("no datsa");
            }
        },

      ),
    );

  }
}
