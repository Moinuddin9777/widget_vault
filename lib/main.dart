import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_vault/UI/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

// While using GetX as state management
// Step 1: Add package
// Step 2: change the MaterialApp method
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: HomeBinding(),
      home: const HomeScreen(),
      // home: FormWithValidation(),
    );
  }
}

// While using Riverpod as state management

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }
