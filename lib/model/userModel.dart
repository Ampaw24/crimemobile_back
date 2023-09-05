import 'package:flutter/material.dart';

class UserModel {
  Data? data;

  UserModel({this.data});

  UserModel.fromJson(Map<dynamic, dynamic>? json) {
    if (json != null) {
      data = Data.fromJson(json: json);
    }
  }
}

class Data {
  String? name;
  String? email;
  String? studentId;
  String? firebaseId;

  Data({
    this.email,
    this.firebaseId,
    this.name,
    this.studentId,
  });

  Data.fromJson({
    @required Map<dynamic, dynamic>? json,
  }) {
    firebaseId = json!['firebaseId'];
    studentId = json['studentId'];
    firebaseId = json['firebaseId'];
    name = json['name'];
  }
}