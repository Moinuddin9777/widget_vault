import 'package:flutter/material.dart';

class BrandDetails extends StatefulWidget {
  const BrandDetails(
      {required this.brandId,
      required this.brandName,
      required this.imageUrl,
      super.key});

  final String brandName;
  final String brandId;
  final String imageUrl;

  @override
  State<BrandDetails> createState() => _BrandDetailsState();
}

class _BrandDetailsState extends State<BrandDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(widget.brandName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          Text('ID:' + widget.brandId),
          Text('Name:' + widget.brandName),
        ],
      ),
    );
  }
}
