import 'package:flutter/material.dart';

class Product {
  int id;
  String name;
  String description;
  double price;
  int disponibility;
  List<Image>? images;
  IconData icon;

  Product({
    required this.id,
    required this.name,
    this.description = '',
    this.price = 0,
    this.disponibility = 0,
    this.images,
    this.icon = Icons.shopping_bag,
  });
}
