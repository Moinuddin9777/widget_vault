import 'package:flutter/material.dart';
// import 'package:widget_vault/UI/widgets/brand_button.dart';
import 'package:widget_vault/UI/widgets/brand_card.dart';
// import 'package:widget_vault/brand_model.dart';
import 'package:widget_vault/placeholder_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// RESPOSIVENESS
///
/// Layout Builder
/// MediaQuery
/// plugin
///

class _HomeScreenState extends State<HomeScreen> {
  List<Brand> brandList = brandsData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 400) {
            // print("*************************************");
            // print(MediaQuery.of(context).size.width);
            // print("*************************************");
            return const TabGrid();
          } else {
            return const MobileGrid();
          }
        }),
      ),
    ));
  }
}

class TabGrid extends StatelessWidget {
  const TabGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<Brand> brandList = brandsData;
    return Column(
      children: [
        Row(
          children: [
            Card(
              color: Colors.amber,
              child: Container(
                width: 300,
                height: 200,
              ),
            ),
            Text(
                "This is some text that goes along with the, This is some text that goes along with the , This is some text that goes along with the  ")
          ],
        ),
        Expanded(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6),
              itemCount: brandList.length,
              itemBuilder: (context, index) {
                return BrandCard(
                    // brandName: brandList[index].title,
                    assetLink: brandList[index].imageUrl);
              }),
        ),
      ],
    );
  }
}

class MobileGrid extends StatelessWidget {
  const MobileGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<Brand> brandList = brandsData;
    return Column(
      children: [
        Column(
          children: [
            Card(
              color: Colors.amber,
              child: Container(
                width: 200,
                height: 100,
              ),
            ),
            Text(
                "This is some text that goes along with the, This is some text that goes along with the , This is some text that goes along with the  ")
          ],
        ),
        Expanded(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: brandList.length,
              itemBuilder: (context, index) {
                return BrandCard(
                    // brandName: brandList[index].title,
                    assetLink: brandList[index].imageUrl);
              }),
        ),
      ],
    );
  }
}
