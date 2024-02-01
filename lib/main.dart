import 'package:assignment2/app/view/homepage.dart';
import 'package:assignment2/app/view/nextpage.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';



void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
 @override
 Widget build(BuildContext context ){
   return  GetMaterialApp(
    initialRoute: '/' ,
    getPages: [GetPage(name: '/', page: ()=>homepage()),
    GetPage(name: "/next", page: ()=>nextpage())],
    home: homepage(),
   );
 }
}



