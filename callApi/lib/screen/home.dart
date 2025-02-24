import 'dart:convert';

import 'package:firstapp/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rest API Call')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final color = user.gender == 'male' ? Colors.blue : Colors.green;

          return ListTile(
            title: Text(user.name.first),
            subtitle: Text(user.phone),
            // tileColor: color,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: fetchUsers),
    );
  }

  void fetchUsers() async {
    print("Fetch user call");
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final tranformed =
        results.map((e) {
          final name = UserName(
            title: e['name']['title'],
            first: e['name']['first'],
            last: e['name']['last'],
          );
          return User(
            gender: e['gender'],
            email: e['email'],
            phone: e['phone'],
            cell: e['phone'],
            nat: e['nat'],
            name: name,
          );
        }).toList();
    setState(() {
      users = tranformed;
    });
    print('fetchUser completed');
  }
}
