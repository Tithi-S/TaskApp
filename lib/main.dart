import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taskapp/postpage.dart';
//import 'Postpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Task',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  //const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Task'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final email = user.email;
            final first_name = user.first_name;
            final imageUrl = user.avatar;
            final last_name = user.last_name;
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
              title: Text('${first_name} ${last_name}'),
              subtitle: Text(email),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToScreen(context);
        },

        //tooltip: 'Create User',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> fetchUsers() async {
    print('fetchUser called');
    final url = "https://reqres.in/api/users?page=2";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    if (response.statusCode == 200) {
      final jsonData = json.decode(body);

      setState(() {
        users = List<User>.from(jsonData['data'].map((x) => User.fromJson(x)));
      });
      print('fetchUsers completed');
    }
  }
}

class User {
  final int id;
  final String first_name;
  final String last_name;
  final String email;
  final String avatar;

  User(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // String idString = responseJson.toString();
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }
}

void _navigateToScreen(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => PostPage()));
}
