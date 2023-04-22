import 'package:flutter/material.dart';
import 'package:mini_store/object/product.dart';

class Category {
  String name;
  String description;
  IconData icon;
  Color color;
  List<Product> products = [];

  Category({
    required this.name,
    this.description = '',
    this.icon = Icons.store,
    this.color = Colors.lightBlue,
  });
}
