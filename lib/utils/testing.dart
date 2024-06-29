import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Testing extends StatefulWidget {
  Testing({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    fetchUserData();

  }

  Future<void> _updateData(int id) async {
    try {
      final response = await http.put(
          Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'title': 'Flutter HTTP CRUD',
            'body':
            'This is an updated blog post about HTTP CRUD methods in Flutter',
          }));

      if (response.statusCode == 200) {
        fetchUserData();
      } else {
        throw Exception('Failed to update data');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _deleteData(int id) async {
    try {
      final response = await http
          .delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));

      if (response.statusCode == 200) {
        fetchUserData();
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (error) {
      print(error);
    }
  }


  Future<void> fetchUserData() async {
    try {
      final response = await http
          .get(Uri.parse('https://api.escuelajs.co/api/v1/users'));

      if (response.statusCode == 200) {
        setState(() {
          _data = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 1,
        title: Text('Users Data',style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) {
          final data = _data[index];
          return Column(
            children: [
              ListTile(
                title: Text(data['name']),
                       subtitle: Text(data['email']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _updateData(data['id']),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteData(data['id']),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),

    );
  }
}