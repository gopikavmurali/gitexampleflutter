import 'dart:convert';

import 'package:api_example/productlist/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ProductListDisplay.dart';


class ProductList extends StatefulWidget {

  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

   Future<List<Product>> getproductlist() async
   {
     var response = await http.get(Uri.parse("https://dummyjson.com/products"));
     var jsondata = jsonDecode(response.body);
     var resp = ProductListModel.fromJson(jsondata);
     var listofprod = resp.products;
     return listofprod;

   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: FutureBuilder(
        future: getproductlist(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
            {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: ()
                      {
                        Navigator.push(context,MaterialPageRoute(
                            builder: (context) => ListDisplay(
                              images: snapshot.data![index].images,)));
                      },
                      leading: CircleAvatar(
                        child: Image.network("${snapshot.data![index].thumbnail}"),

                      ),
                      title: Text("${snapshot.data![index].title}"),
                      subtitle: Row(
                        children: [
                          Text("${snapshot.data![index].price}"),
                          SizedBox(width: 2,),
                          Text("${snapshot.data![index].brand}"),
                          SizedBox(width: 2,),
                          Text("${snapshot.data![index].discountPercentage}"),

                        ],
                      ),
                      trailing: Text("${snapshot.data![index].id}"),
                    );
                  },
              );
            }
          else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

        },
      ),
    );
  }
}
