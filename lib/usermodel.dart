// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class UserModel {
  final String name;
  final String job;
  UserModel({required this.name, required this.job});
  Map<String, dynamic> ToJson() {
    return {
      "name": name,
      "job": job,
    };
  }
}

class ResponseModel {
  final String name;
  final String job;
  final String id;
  final DateTime createdAt;

  ResponseModel(
      {required this.name,
      required this.job,
      required this.id,
      required this.createdAt});

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        name: json["name"],
        job: json["job"],
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
      );
}

class ApiClient {
  Future request(
      {required String path,
      required Map<String, dynamic> data,
      String type = "get"}) async {
    final response = type == "get"
        ? await http.get(Uri.parse("https://reqres.in/api/users"))
        : await http.post(Uri.parse("https://reqres.in/api/users"));
    headers:
    <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    body:
    jsonEncode(data);

    return response;
  }
}

class UserRequestModel {
  final String name;
  final String job;

  UserRequestModel({required this.name, required this.job});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "job": job,
    };
  }
}

class UserRepo {
  static const String endpoint = "https://reqres.in/api/users";
  Future<ResponseModel> createUser(Map<String, dynamic> UserModel) async {
    http.Response result = await ApiClient()
        .request(path: endpoint, data: UserModel, type: "post");
    if (result.statusCode == 201) {
      return ResponseModel.fromJson(jsonDecode(result.body));
    } else {
      throw Exception('Failed to Post data. ');
    }
  }
}
