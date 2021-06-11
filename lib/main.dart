import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:connectivity/connectivity.dart';
import 'package:medical_app/screens/form.dart';
import 'package:medical_app/services/shared_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_provider.dart';
import 'services/api_call.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterBackgroundService.initialize(onStart);

  runApp(MyApp());
}

void onStart() {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  service.onDataReceived.listen((event) {
    if (event["action"] == "setAsForeground") {
      service.setForegroundMode(true);
      return;
    }

    if (event["action"] == "setAsBackground") {
      service.setForegroundMode(false);
    }

    if (event["action"] == "stopService") {
      service.stopBackgroundService();
    }
  });

  // bring to foreground
  service.setForegroundMode(true);
  Timer.periodic(Duration(seconds: 1), (timer) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _connectionStatus = _prefs.getBool("dataStoredLocally") != null &&
            _prefs.getBool("dataStoredLocally")
        ? "Uploading"
        : "";
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      // Got a new connectivity status!
      _connectionStatus = "App running on " + result.toString();
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      print(_connectionStatus);
      print("hhhh" + _prefs.get("dataStoredLocally").toString());
      if (_connectionStatus == "ConnectivityResult.wifi" &&
          _prefs.getBool("dataStoredLocally")) {
        _connectionStatus = "Uploading data to server";
        getDataFromLocal().then((value) {
          if (value != null) {
            ApiCall().insertData(model: value);
            destroyLocalCopy();
            _connectionStatus = "Upload complete to server!";
          }
        });
      }
    });
    if (!(await service.isServiceRunning())) timer.cancel();
    service.setNotificationInfo(
      title: "Medical app",
      content: _connectionStatus,
    );

    service.sendData(
      {"current_date": DateTime.now().toIso8601String()},
    );
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String text = "Stop Service";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MyProvider()),
        ],
        child:
            MaterialApp(debugShowCheckedModeBanner: false, home: FormScreen()));
  }
}
