import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProvider with ChangeNotifier {
  setBoolVal(bool val) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("dataStoredLocally", val);
    notifyListeners();
  }

  getBoolVal() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool("dataStoredLocally");
  }
}
