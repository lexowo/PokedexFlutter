import 'package:flutter/material.dart';
import 'package:practica5_api/src/view/detail_screen.dart';
import 'package:practica5_api/src/view/home_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/detail'       : (BuildContext context) => DetailScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Pokemon'),
      home: HomeApi(),
    );
  }
}