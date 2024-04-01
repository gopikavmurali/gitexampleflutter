import 'package:api_example/marchapi/user_api.dart';
import 'package:api_example/marchapi/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});


  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  //UserApi service = UserApi;
  UserApi service = UserApi();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: service.getuser(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
            {
              return Scaffold(
                body: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Image.network("${snapshot.data?[index].image}"),
                      ),
                      title: Text("${snapshot.data?[index].username}"),
                    );

                  },),
              );
            }
          else
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

        },
    );
  }
}
