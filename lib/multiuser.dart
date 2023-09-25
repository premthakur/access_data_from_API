import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restapi1/main.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(Myapp());
}

class Multiuser extends StatefulWidget {
  const Multiuser({super.key});

  @override
  State<Multiuser> createState() => _MultiuserState();
}

class _MultiuserState extends State<Multiuser> {
  Map<String, dynamic>? datamap;
  List<dynamic>? donelist;

  Future multiuser() async {
    http.Response response =
        await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        datamap = jsonDecode(response.body);
        donelist = datamap!["data"];
      });
    }
  }
  @override
  void initState() {
    multiuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:donelist==null ? CupertinoActivityIndicator(): ListView.builder(

          itemCount: datamap!.length,
          itemBuilder: (context, index) {
          return ListTile(
            trailing: CircleAvatar(
              child: Text(donelist![index]["id"].toString()),

              backgroundColor: Colors.red,
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(donelist![index]["avatar"]),

            ),
            title: Text(donelist![index]["first_name"]+ " "+ donelist![index]["last_name"]),
            subtitle: Text(donelist![index]["email"]),
          );
        },),
      ),
    );
  }
}
