import 'dart:convert';
import 'package:crimeappbackend/module/adminmodule.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/firebase/firebaseAuth.dart';
import 'package:rxdart/rxdart.dart';

final _fetcher = BehaviorSubject<AdminModel>();
Sink<AdminModel> get _fetcherSink => _fetcher.sink;
Stream<AdminModel> get userModelStream => _fetcher.stream;
AdminModel? adminModel;

class AdminDetailsProvider {
  Future<void> get() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("auth") && prefs.getBool("auth")!) {
      if (prefs.containsKey("userDetails")) {
        String encodedData = prefs.getString("userDetails")!;
        var decodedData = json.decode(encodedData);
        if (kDebugMode) {
          print(decodedData);
        }
        adminModel = AdminModel.fromJson(decodedData);
        firebaseUserId = adminModel!.data!.firebaseId;
        _fetcherSink.add(adminModel!);
      }
    }  else {
      adminModel = null;
    }
  }
}