import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../sharePreference.dart';

abstract class BaseProfile {
  Future<void> createAccount();
Future<Map<dynamic, dynamic>?> getAccountDetails(String id);
  Future<void> setUserStatus({@required bool status});
}

class FireProfile implements BaseProfile {
  final _database = FirebaseDatabase.instance.ref();

  final _databaseRef = FirebaseDatabase.instance.ref().child("Users");

  @override
  Future<void> createAccount({
    @required String? email,
    @required String? firebaseUserId,
    @required String? userId,
    @required String? name,
  }) async {
    await _database.child("Users").child(userId!).set({
      "firebaseId": firebaseUserId,
      "studentId": userId,
      "email": email,
      "name": name,
    });
    saveStringShare(key: "firebaseUserId", data: firebaseUserId);
  }

  @override
  Future<void> setUserStatus({@required bool? status}) async {
    // SharedPreferences? prefs = await SharedPreferences.getInstance();
    // if (prefs.containsKey("auth") && prefs.getBool("auth")!)
    //   await _database.child("Users").child(userModel!.data!.user!.userid!).update({
    //     "online": status,
    //   });
  }
  
 @override
  Future<Map<dynamic, dynamic>> getAccountDetails(String id) async {
    Map<dynamic, dynamic>? meta;
    await _databaseRef.child(id).get().then((DataSnapshot value) {
      if (value.exists) {
        meta = value.value as Map;
        return meta;
      }
    });
    return meta!;
  }
}