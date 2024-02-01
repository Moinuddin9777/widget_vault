import 'dart:io';

import 'package:flutter/material.dart';

class PassingData {
  PassingData(
      {required this.name,
      required this.image,
      required this.lat,
      required this.long});
  final String name;
  final File image;
  final String lat;
  final String long;
}
