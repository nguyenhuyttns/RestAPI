import 'dart:convert';
import 'package:firstapp/model/user.dart';
import 'package:firstapp/model/user_name.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static Future<List<User>> fetchUsers() async {
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final users =
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
    return users;
  }
}
