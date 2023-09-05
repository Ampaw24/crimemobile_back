import 'package:flutter/material.dart';

class AdminModel {
  Data? data;

AdminModel({this.data});

AdminModel.fromJson(Map<dynamic, dynamic>? json) {
    if (json != null) {
      data = Data.fromJson(json: json);
    }
  }
}

class Data {
  String? name;
  String? email;
  String? staffId;
  String? firebaseId;

  Data({
    this.email,
    this.firebaseId,
    this.name,
    this.staffId,
  });

  Data.fromJson({
    @required Map<dynamic, dynamic>? json,
  }) {
    firebaseId = json!['firebaseId'];
    staffId = json['staffId'];
    firebaseId = json['firebaseId'];
    name = json['name'];
  }
}