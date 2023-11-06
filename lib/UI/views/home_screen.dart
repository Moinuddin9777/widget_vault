import 'package:flutter/material.dart';
import 'package:widget_vault/UI/widgets/brand_button.dart';
import 'package:widget_vault/brand_model.dart';
import 'package:widget_vault/placeholder_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Brand> brandList = brandsData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: brandList.length,
          itemBuilder: (context, index) {
            return BrandButton(
                brandName: brandList[index].title,
                imageUrl: brandList[index].imageUrl);
          }),
    );
  }
}
