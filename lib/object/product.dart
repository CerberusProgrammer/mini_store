import 'package:flutter/foundation.dart';

class Product {
  int id;
  String name;
  String description;
  double price;
  int disponibility;
  Category category;

  Product({
    required this.id,
    required this.name,
    this.description = '',
    required this.price,
    required this.disponibility,
    required this.category,
  });
}
