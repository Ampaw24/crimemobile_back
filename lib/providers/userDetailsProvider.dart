import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/firebase/firebaseAuth.dart';
import '../model/userModel.dart';

final _fetcher = BehaviorSubject<UserModel>();
Sink<UserModel> get _fetcherSink => _fetcher.sink;
Stream<UserModel> get userModelStream => _fetcher.stream;
UserModel? userModel;

class UserDetailsProvider {
  Future<void> get() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("auth") && prefs.getBool("auth")!) {
      if (prefs.containsKey("userDetails")) {
        String encodedData = prefs.getString("userDetails")!;
        var decodedData = json.decode(encodedData);
        if (kDebugMode) {
          print(decodedData);
        }
        userModel = UserModel.fromJson(decodedData);
        firebaseUserId = userModel!.data!.firebaseId;
        _fetcherSink.add(userModel!);
      }
    }  else {
      userModel = null;
    }
  }
}