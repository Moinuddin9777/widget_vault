import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({required this.assetLink, super.key});

  final String assetLink;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          image: DecorationImage(image: NetworkImage(assetLink)),
        ),
      ),
    );
  }
}
