import 'package:flutter/material.dart';
import 'pages/eat_page.dart';
import 'pages/category_page.dart';
import 'pages/cart_page.dart';
import 'pages/personal_page.dart';
import 'pages/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      initialRoute: "/index",
      routes: {
        '/index': (context) => MainPage(),
        "/category": (context) => CategoryPage(),
        "/eat": (context) => EatPage(),
        "/cart": (context) => CartPage(),
        "/me": (context) => PersonalPage(),
      },
      theme: ThemeData(
          primarySwatch: Colors.blue,
          splashColor: Colors.orangeAccent,
          highlightColor: Color.fromRGBO(255, 255, 255, 0.5)),
    );
  }
}
