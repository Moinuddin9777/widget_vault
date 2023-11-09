import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:widget_vault/UI/views/brand_details_page.dart';
import 'package:widget_vault/core/app_images.dart';
import 'package:widget_vault/placeholder_data.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({required this.pageName, super.key});

  final String pageName;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Category> listOfCategories = categoriesData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(widget.pageName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: CustomScrollView(
          slivers: [
            SliverList.builder(
                itemCount: listOfCategories.length,
                itemBuilder: (context, index) {
                  return CategoryTile(
                      brandName: listOfCategories[index].name,
                      listOfBrands: listOfCategories[index].brandsList,
                      categoryId: listOfCategories[index].catId);
                })
          ],
        ),
      ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     SizedBox(width: double.infinity),
      //     CategoryTile(brandName: brandName, listOfBrands: listOfBrands, categoryId: categoryId)
      //     // Text('PRODUCTS PAGE'),
      //     // ElevatedButton(
      //     //     onPressed: () {
      //     //       Navigator.of(context).push(MaterialPageRoute(
      //     //           builder: (context) => BrandDetails(
      //     //               brandId: "id1234",
      //     //               brandName: "Maybelline",
      //     //               imageUrl: "imageUrl")));
      //     //     },
      //     //     child: Text('Go to brand'))
      //   ],
      // ),
    );
  }
}

class CategoryTile extends StatefulWidget {
  const CategoryTile(
      {required this.brandName,
      required this.listOfBrands,
      required this.categoryId,
      super.key});

  final List<Brand> listOfBrands;
  final int categoryId;
  final String brandName;

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: ElevatedButton(
          onPressed: () {},
          // width: 40,
          // color: Colors.purple,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ExpansionTile(
                    title: Text(widget.brandName),
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Text(widget.categoryId.toString()),
                    ),
                    children: widget.listOfBrands
                        .map((element) => Text(element.title))
                        .toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
