import 'dart:convert';

import 'package:api_example/carts/Cart.dart';
import 'package:api_example/carts/Carts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartDetails extends StatefulWidget {
  const CartDetails({super.key});

  @override
  State<CartDetails> createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {

  Future<List<Carts>?>getData() async {
    var respo = await http.get(Uri.parse("https://dummyjson.com/carts"));
    var jso = jsonDecode(respo.body);
    var resss= Cart.fromJson(jso);
    var list = resss.carts;
    return list;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Details"),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<List<Carts>?> snapshot)
        {
          if(snapshot.hasData)
            {
              return ListView.builder(
                  itemBuilder: (BuildContext context,int index)
              {
                return ListTile(
                  title: Row(
                    children: [
                      Text("${snapshot.data![index].totalProducts}"),
                      Text("${snapshot.data![index].total}"),

                    ],
                  ),
                  leading:  Text("${snapshot.data![index].discountedTotal}"),
                  subtitle:  Text("${snapshot.data![index].totalQuantity}"),
                  trailing:  Text("${snapshot.data![index].userId}"),
                );
              });
            }
          else
          {
            return Text("no data");
          }
        },

      ),
    );
  }
}
