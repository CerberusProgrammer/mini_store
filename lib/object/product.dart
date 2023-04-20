import 'dart:ui';

class Product {
  int id;
  String name;
  String description;
  double price;
  int disponibility;
  List<Image> images = [];

  Product({
    required this.id,
    required this.name,
    this.description = '',
    this.price = 0,
    this.disponibility = 0,
  });
}
