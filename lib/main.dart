import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assignment2/views/first_page.dart';
import 'package:assignment2/views/second_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => FirstPage(),
        ),
        GetPage(
          name: '/second',
          page: () => SecondPage(),
        ),
      ],
    );
  }
}
