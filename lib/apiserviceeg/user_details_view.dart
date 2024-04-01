
import 'package:api_example/apiserviceeg/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDetailView extends StatefulWidget {

  const UserDetailView({super.key});

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> {
  ApiUser service = ApiUser();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: service.getuserlist(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
            {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("API User List"),
                ),
                body: ListView.builder(
                  itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return  ListTile(
                        leading: CircleAvatar(
                          child: Image.network("${snapshot.data?[index].image}"),

                        ),
                        title: Row(
                          children: [
                            Text("${snapshot.data?[index].firstName}"),
                            SizedBox(width: 5,),
                            Text("${snapshot.data?[index].lastName}"),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text("${snapshot.data?[index].username}"),
                            SizedBox(width: 5,),
                            Text("${snapshot.data?[index].password}")
                          ],
                        ),
                        trailing: Text("${snapshot.data?[index].height}"),

                      );
                    },),
              );
            }
          else
            {
              return const Center(child: CircularProgressIndicator());
            }
        },


    );
  }
}
