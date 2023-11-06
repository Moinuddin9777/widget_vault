import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:widget_vault/core/app_images.dart';

class BrandButton extends StatefulWidget {
  const BrandButton(
      {required this.brandName, required this.imageUrl, super.key});

  final String brandName;
  final String imageUrl;

  @override
  State<BrandButton> createState() => _BrandButtonState();
}

class _BrandButtonState extends State<BrandButton> {
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
              Text(widget.brandName),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(AppImages.cartIcon),
              )
            ],
          ),
        ),
      ),
    );
  }
}
