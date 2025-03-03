import 'package:flutter/material.dart';
import 'package:todoapp/screens/todo_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: ToDoListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
