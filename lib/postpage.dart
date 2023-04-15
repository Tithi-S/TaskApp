import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'usermodel.dart';
//import '../repository/repo.dart';

import 'userpage.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'API Task',
      home: PostPage(),
    );
  }
}

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  //const PostPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  // void initState() {
  //   super.initState();
  //   fetchUsers();
  // }
  Future<ResponseModel>? futureuser;
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController jobnamecontroller = TextEditingController();
  @override
  void dispose() {
    namecontroller.clear();
    jobnamecontroller.clear();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [buildColumn(context)],
        ),
      ),
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            controller: namecontroller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter name';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: "Enter Name",
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[80]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter job';
              }
              return null;
            },
            controller: jobnamecontroller,
            decoration: InputDecoration(
                hintText: "Enter Job",
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[80]),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              var userRequestModel = UserRequestModel(
                  name: namecontroller.text, job: jobnamecontroller.text);
              final result = UserRepo().createUser(userRequestModel.toJson());
              setState(() {
                futureuser = result;
              });

              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: ((context) => UserPage(
                            data: futureuser,
                          ))));
              // });
            }
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }
}
