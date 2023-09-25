import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}


class _HomescreenState extends State<Homescreen> {
  Map<String, dynamic>? fetchdata;
  Map<String, dynamic>? donedata;
  Future callfunction() async{
    http.Response response= await http.get(Uri.parse("https://reqres.in/api/users/2"));
    if(response.statusCode==200){
      var fetchdata= jsonDecode(response.body);
      setState(() {
        donedata=fetchdata['data'];
        print(donedata);
      });
    }
  }
  @override
  void initState() {
    callfunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API-1"),
      ),
      body: Center(child:
      donedata== null ? CupertinoActivityIndicator():
      ListTile(
        title: Text(donedata!["first_name"]+ " "+ donedata!["last_name"] ),
        subtitle: Text(donedata!["email"]),
      )),


    );
  }
}
