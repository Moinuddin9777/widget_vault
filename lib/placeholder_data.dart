// import 'package:widget_vault/brand_model.dart';

class Brand {
  const Brand({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String imageUrl;
}

class Category {
  Category({
    required this.catId,
    required this.brandsList,
    required this.name,
  });

  final List<Brand> brandsList;
  final int catId;
  final String name;
}

List<Category> categoriesData = <Category>[
  Category(
      catId: 1,
      brandsList: const [
        Brand(id: "id1", title: "Maybelline", imageUrl: "imageUrl"),
        Brand(id: "id3", title: "Lakme", imageUrl: "imageUrl"),
        Brand(id: "id8", title: "Colorpop", imageUrl: "imageUrl"),
      ],
      name: "Makeup"),
  Category(
      catId: 2,
      brandsList: const [
        Brand(id: "id2", title: "H&M", imageUrl: "imageUrl"),
        Brand(id: "id7", title: "Levis", imageUrl: "imageUrl"),
        Brand(id: "id6", title: "GoodCloth", imageUrl: "imageUrl"),
      ],
      name: "Clothing"),
  Category(
      catId: 3,
      brandsList: const [
        Brand(id: "id1", title: "RedTape", imageUrl: "imageUrl"),
        Brand(id: "id8", title: "Sneakers", imageUrl: "imageUrl"),
        Brand(id: "id8", title: "Bata", imageUrl: "imageUrl"),
      ],
      name: "Shoes"),
];

List<Brand> brandsData = const <Brand>[
  Brand(id: "id1", title: "Maybelline", imageUrl: "imageUrl"),
  Brand(id: "id2", title: "Loreal", imageUrl: "imageUrl"),
  Brand(id: "id3", title: "Lakme", imageUrl: "imageUrl"),
  Brand(id: "id4", title: "BrandName", imageUrl: "imageUrl"),
  Brand(id: "id5", title: "BrandName2", imageUrl: "imageUrl"),
  Brand(id: "id6", title: "SomeBrand", imageUrl: "imageUrl"),
  Brand(id: "id7", title: "Colorpop", imageUrl: "imageUrl"),
  Brand(id: "id8", title: "Axis", imageUrl: "imageUrl"),
  Brand(id: "id9", title: "Moonlight", imageUrl: "imageUrl"),
];
