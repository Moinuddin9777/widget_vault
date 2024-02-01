import 'dart:io';
import 'package:geolocator/geolocator.dart';

class User {
  const User({
    required this.name,
    required this.image,
    required this.location,
  });
  final String name;
  final File? image;
  final Position? location;
}
