import 'dart:convert';
import 'package:api_example/apidatas.dart';
import 'package:api_example/imagesdata.dart';
import 'package:api_example/model/Resp.dart';
import 'package:api_example/productlist/product_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'apiserviceeg/user_details_view.dart';
import 'cartdetails.dart';
import 'marchapi/user_view.dart';
import 'model/Products.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ProductList()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  Future<List<Products>?>fetchdata() async {
    var resp=await http.get(Uri.parse("https://dummyjson.com/products"));
    var jsondata=jsonDecode(resp.body);
    var res=Resp.fromJson(jsondata);
    var list=res.products;
    return list;


  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder(future: fetchdata(),
        builder: (BuildContext context, AsyncSnapshot<List<Products>?> snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: (){
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ImageData(images: snapshot.data![index].images,
                //
                //   )),
                // );
                print(snapshot.data?[index].thumbnail ?? "");
              },
              leading: CircleAvatar(
                backgroundImage: NetworkImage("${snapshot.data?[index].thumbnail ?? ""}"),
              ),

            title: Text('${snapshot.data![index].title}'),
              subtitle: Row(
                children: [
                  Text("${snapshot.data![index].category}"),
                  SizedBox(width: 5,),
                  Text("${snapshot.data![index].price}"),
                ],
              ),
              trailing: Column(
                children: [
                  Text("${snapshot.data![index].brand}"),
                  Text("${snapshot.data![index].description}"),
                  Text("${snapshot.data![index].id}"),

                ],
              ),
            );
          },
          );
        }
        else{
          return Text("no data");
        }

      },),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
