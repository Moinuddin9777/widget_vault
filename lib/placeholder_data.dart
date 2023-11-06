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
