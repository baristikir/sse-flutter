
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:websocket_tests/screens/another_home_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true; // add your localhost detection logic here if you want
  }
}

void main() => {
    HttpOverrides.global = new MyHttpOverrides(),
  runApp(MyApp()
  )};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'WebSocket Demo';
    return MaterialApp(
      title: title,
      home: SSEHomePage(
        title: title,
      ),
    );
  }
}