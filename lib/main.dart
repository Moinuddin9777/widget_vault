import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_vault/views/front_page.dart';
import 'package:widget_vault/views/next_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Your Updated App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.orange,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/first',
      getPages: [
        GetPage(
          name: '/first',
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
