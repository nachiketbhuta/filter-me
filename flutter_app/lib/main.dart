import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Jobs",
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
      },
    ),
  );
}
