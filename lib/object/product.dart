import 'package:flutter/foundation.dart';

class Product {
  String name;
  String description;
  double price;
  int disponibility;
  Category category;

  Product({
    required this.name,
    this.description = '',
    required this.price,
    required this.disponibility,
    required this.category,
  });
}
