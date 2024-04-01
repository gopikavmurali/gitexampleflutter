import 'package:flutter/material.dart';

class ImageData extends StatefulWidget {
  List<String>? images;

  ImageData({ required this.images}); // const ImageData({super.key});

  @override
  State<ImageData> createState() => _ImageDataState();
}

class _ImageDataState extends State<ImageData> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Images"),
      ),
      body: ListView.builder(
        itemCount: widget.images!.length,
          itemBuilder: (BuildContext context,int index)
      {
        return ListTile(
          onTap: () {
            print(widget.images?[index] ?? "");
          },

          leading: CircleAvatar(
            backgroundImage: NetworkImage("https://picsum.photos/seed/picsum/200/300"),
          ),
        );
      }),
    );
  }
}
