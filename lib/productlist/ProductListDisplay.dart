import 'package:flutter/material.dart';

class ListDisplay extends StatefulWidget {
   List<String>? images;
   
   ListDisplay({super.key,required this.images});

  @override
  State<ListDisplay> createState() => _ListDisplayState();
}

class _ListDisplayState extends State<ListDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: widget.images!.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Image.network("${widget.images![index]}"),
              ),
            );
          },),
    );
  }
}
