import 'package:flutter/material.dart';

class DataDisplay extends StatefulWidget {
  List<String>? img;

  DataDisplay({ required this.img}); // const ImageData({super.key});

  @override
  State<DataDisplay> createState() => _DataDisplayState();
}

class _DataDisplayState extends State<DataDisplay> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Images"),
      ),
      body: ListView.builder(
          itemCount: widget.img!.length,
          itemBuilder: (BuildContext context,int index)
          {
            return ListTile(
              onTap: () {
                print(widget.img?[index] ?? "");
              },

              leading: CircleAvatar(
                backgroundImage: NetworkImage("${widget.img![index]}"),
              ),
            );
          }),
    );
  }
}
