import 'package:flutter/material.dart';
import 'package:mini_store/object/category.dart';

class Product {
  int id;
  String name;
  String description;
  double price;
  int disponibility;
  int quantity;
  List<ImageProvider> images = [];
  Color color;
  IconData icon;
  Category category;

  Product({
    required this.id,
    required this.name,
    required this.color,
    required this.category,
    this.description = '',
    this.price = 0,
    this.disponibility = 0,
    this.quantity = 0,
    this.icon = Icons.shopping_bag,
  });
}
